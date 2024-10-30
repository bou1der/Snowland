{ pkgs, lib, ... }:

{
  networking.hostName = "nixos-server";

  networking = {
    nat.enable = true;
    nat.externalInterface = "eth0";
    nat.internalInterfaces = [ "wg0" ];

    firewall.enable = true;
    firewall.allowedTCPPorts = [ 22001 30033 25565 ];
    firewall.allowedUDPPorts = [ 9987 51820 ];
  };
}
