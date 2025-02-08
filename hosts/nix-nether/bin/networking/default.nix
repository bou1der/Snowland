{ pkgs, lib, ... }:

{
  networking.hostName = "nix-nether";

  networking = {
    firewall.enable = false;
    firewall.allowedTCPPorts = [ 51820 8380 22001 39531 ];
    firewall.allowedUDPPorts = [ 51820 8380 ];
  };
}
