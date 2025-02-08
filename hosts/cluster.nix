{ config, lib, pkgs, ... }:

let
  cfg = config.cluster;
  env = path: builtins.readFile config.sops.secrets."${path}".path;
  master-ip = if (cfg.role == "master") then "127.0.0.1" else env "k8s/master-ip";
  hostname = if (cfg.role == "master") then "api.kube" else "booulder.xyz";
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
  };


  config = lib.mkIf cfg.enable {

    networking.extraHosts = "${master-ip} ${hostname}"; 

    environment.systemPackages = if (cfg.role == "master") then [
      pkgs.kompose
      pkgs.kubectl
      pkgs.kubernetes
    ] else [
    ];

    services.kubernetes = {

      masterAddress = hostname;
      apiserverAddress = "https://${hostname}:${toString vars.master-port}";
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

      # proxy = {
      #   enable = true;
      # };

      flannel = if (cfg.role == "master")
        then {
          enable = true;
          openFirewallPorts = true;
        } else {};


      addons.dns.enable = true;

      kubelet = {
        # enable = if cfg.role == "master" then false else true;
        kubeconfig.server = "https://${hostname}:${toString vars.master-port}";
        extraConfig = {
          failSwapOn = false;
        };
      };
    };
  };
}
