{ config, ... }:

let
  env = path: builtins.readFile config.sops.secrets."${path}".path;
in 
{
  imports = [
    ./proxy.nix
  ];

  networking.firewall.enable = true;

  networking.extraHosts = "${env "k8s/master-ip"} api.kube"; 

  networking.networkmanager = {
    enable = true;
    dns = "systemd-resolved";
    insertNameservers = [ "208.67.222.222" "208.67.220.220" ];
  };
}
