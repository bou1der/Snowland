{ pkgs, lib, ... }:

{
  networking.hostName = "nixos-server";

  networking = {
    firewall.enable = true;
    firewall.allowedTCPPorts = [ 51820 8380 22001 39531 ];
    firewall.allowedUDPPorts = [ 51820 8380 ];
  };
}
