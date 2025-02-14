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
        ${pkgs.tailscale}/bin/tailscale up --login-server $API_URL --authkey $AUTHKEY
      '';
      after = if cfg.role == "master" then [ "headscale.service" ] else [];
      # wantedBy = [ "tailscaled.services" ];
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
      serverAddr = "https://api.kube:6443";
      role = if cfg.role == "master" then "server" else "agent";
      extraFlags = if cfg.role == "master" then [
        "--write-kubeconfig-mode \"0644\""
        "--tls-san=api.kube"
        "--cluster-init"
      ] else [];
      clusterInit = if cfg.role == "master" then true else false;
    };
  };
}
