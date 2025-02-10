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

    environment.systemPackages = with pkgs; [
      nodejs_22
      kompose
      kubectl
      kubernetes
      kubernetes-helm
    ];

    systemd.services.prepare-vpn-client = {
      script = ''
        #!${pkgs.bash}/bin/bash
        API_URL="${if cfg.role == "master" then "http://127.0.0.1:9090" else "https://${env "vpn/domain"}"}"
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

    services.kubernetes = {

      masterAddress = "api.kube";
      apiserverAddress = "https://api.kube:${toString vars.master-port}";
      easyCerts = true;

      roles = if cfg.role == "master" then [
        "master"
        "node"
      ] else [ "node" ];

      apiserver = if (cfg.role == "master")
      then {
        enable = true;
        securePort = vars.master-port;
        advertiseAddress = master-ip;
        bindAddress = "0.0.0.0";
      }
      else {};

      addons.dns.enable = true;

      kubelet = {
        kubeconfig.server = "https://api.kube:${toString vars.master-port}";
        extraConfig = {
          failSwapOn = false;
        };
      };
    };
    
  };
}
