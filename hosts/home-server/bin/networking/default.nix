{ pkgs, lib, ... }:

{
  networking.hostName = "nixos-server";

  networking = {
    nat.enable = true;
    nat.externalInterface = "eth0";
    nat.internalInterfaces = [ "wg0" ];

    firewall.enable = true;
    firewall.allowedTCPPorts = [

      22001 30033 25565 8000

      6001 6002

      18080 18081 18082 18083 18085 18089

      8006 3389

      80 443 2424 5000 3000 8080
    ];
    firewall.allowedUDPPorts = [
      9987 51820 3389
    ];
  };
}
