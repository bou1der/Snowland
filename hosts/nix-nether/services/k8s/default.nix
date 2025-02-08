{ config, pkgs, ... }:

let
  kubeMasterIP = "45.155.249.80";
  kubeMasterHostname = "kube-master";
  kubeMasterAPIServerPort = 6443;
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
