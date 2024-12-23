{ ... }:

{
  imports = [
    ./proxy.nix
  ];

  networking.firewall.enable = true;

  networking.networkmanager = {
    enable = true;
    dns = "systemd-resolved";
    insertNameservers = [ "208.67.222.222" "208.67.220.220" ];
  };
}
