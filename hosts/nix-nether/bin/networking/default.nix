{ pkgs, lib, ... }:

{
  networking.hostName = "nixos-server";

  networking = {
    firewall.enable = true;
    firewall.allowedTCPPorts = [ 22001 51821 ];
    firewall.allowedUDPPorts = [ 51820 ];
  };
}
