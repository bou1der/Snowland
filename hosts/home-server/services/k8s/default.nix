{ config, pkgs, ... }:
let
  kubeMasterIP = "127.0.0.1";
  kubeMasterHostname = "api.kube";
  kubeMasterAPIServerPort = 6443;
  env = path: builtins.readFile config.sops.secrets."${path}".path;
in
{
  # resolve master hostname
  networking.extraHosts = "${kubeMasterIP} ${kubeMasterHostname}";

  # packages for administration tasks
  environment.systemPackages = with pkgs; [
    kubernetes-helm
    kompose
    kubectl
    kubernetes
  ];

  services.kubernetes = {
    roles = ["master" "node"];
    masterAddress = kubeMasterHostname;
    apiserverAddress = "https://${kubeMasterHostname}:${toString kubeMasterAPIServerPort}";
    easyCerts = true;
    apiserver = {
      securePort = kubeMasterAPIServerPort;
      advertiseAddress = kubeMasterIP;
    };


    # use coredns
    addons.dns.enable = true;

    kubelet = {
      extraConfig = {
        failSwapOn = false;
      };
    };
  };
}
