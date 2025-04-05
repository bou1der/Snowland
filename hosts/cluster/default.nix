{ config, lib, pkgs, ... }:

let
  cfg = config.cluster;
  env = path: builtins.readFile config.sops.secrets."${path}".path;
  master-ip = if (cfg.role == "master") then "127.0.0.1" else env "k8s/master-ip";
  vars = import ./vars.nix;
in 
{
  options.cluster = with lib; {
    enable = lib.mkEnableOption "Add server to cluster pool";
    role = lib.mkOption {
      type = lib.types.enum [ "master" "node" ];
      default = "node";
      description = ''
        Server role in cluster
      '';
    };
    name = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = "node";
      description = ''
        server name vpn
      '';
    };
    ip = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = "10.0.0.0/32";
      description = ''
        ip route to server inside vpn
        IMPORTANT!: set ip if role == "node"
        custom ip dont work with master role
      '';
    };
  };

  imports = [
    ./master-vpn.nix
  ];

  config = lib.mkIf cfg.enable {

    networking.firewall.allowedTCPPorts = [
      80 443
    ];

    environment.systemPackages = with pkgs; [
      nodejs_22
      kompose
      kubectl
      kubernetes
      helmfile
      kubernetes-helm
      cloudflared
    ];

    systemd.services.prepare-vpn-client = {
      script = ''
        #!${pkgs.bash}/bin/bash
        API_URL="${if cfg.role == "master" then "http://127.0.0.1:9090" else "https://tail.${env "vpn/domain"}"}"
        API_KEY="${env "vpn/apikey"}"
        USERNAME="${if cfg.role == "master" then "master" else cfg.name}"

        ${pkgs.tailscale}/bin/tailscale down

        cp -f ${./config/gen-token.js} /var/lib/gen-token.js
        chmod +x /var/lib/gen-token.js

        AUTHKEY=$(${pkgs.nodejs_22}/bin/node /var/lib/gen-token.js "$API_KEY" "$API_URL" "$USERNAME")
        ${pkgs.tailscale}/bin/tailscale up --login-server $API_URL --authkey $AUTHKEY --advertise-routes=${if cfg.role == "master" then env "k8s/master-ip" else cfg.ip} --accept-routes
      '';
      after = if cfg.role == "master" then [ "headscale.service" ] else [];
      wantedBy = if cfg.role == "master" then [] else [ "k3s.service" ];
    };


    services.tailscale = {
      enable = true;
      openFirewall = true;
      useRoutingFeatures = "client";
    };

    networking.extraHosts = "${master-ip} api.kube"; 

    virtualisation.containerd.enable = true;

   # services.cloudflared = {
   #    enable = true;
   #
   #    tunnels."<tunnel-id>" = {
   #      credentialsFile = "${config.sops.secrets."cloudflare/credential".path}";
   #      default = "http_status:404";
   #    };
   #  };

    services.k3s = {
      enable = true;
      token = env "k8s/server-token";
      role =  if cfg.role == "master" then "server" else "agent";
      extraFlags = if cfg.role == "master" then [
        "--write-kubeconfig-mode \"0644\""
        "--tls-san=46.150.174.46"
        "--cluster-init"
      ] else [
        "--server=https://${env "k8s/master-ip"}:6443"
        # "--token=${env "k8s/server-token"}"
      ];
      clusterInit = if cfg.role == "master" then true else false;

      manifests = if cfg.role == "master" then {
        nether-role = {
          enable = true;

          content = [
            {
              apiVersion = "rbac.authorization.k8s.io/v1";
              kind = "ClusterRole";
              metadata = {
                name = "system:node:nix-nether";
              };
              rules = [
                {
                  apiGroups = [""];
                  # resources = ["nodes" "pods" "services" "namespaces" "endpoints"];
                  # verbs = [ "get" "list" "watch"];
                  resources = ["*"];
                  verbs = ["*"];
                }
              ];
            }
            {
              apiVersion = "rbac.authorization.k8s.io/v1";
              kind = "ClusterRoleBinding";
              metadata = {
                name = "system:node:nix-nether";
              };
              roleRef = {
                apiGroup = "rbac.authorization.k8s.io";
                kind = "ClusterRole";
                name = "system:node:nix-nether";
              };
              subjects = [
                {
                  kind = "User";
                  name = "system:node:nix-nether";
                  apiGroup = "rbac.authorization.k8s.io";
                }
              ];
            }
          ];
        };

      } else {};

    };

  };
}
