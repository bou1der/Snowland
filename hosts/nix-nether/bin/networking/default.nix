{ pkgs, lib, ... }:

{
  networking.hostName = "nether";

  networking = {
    firewall.enable = false;
    firewall.allowedTCPPorts = [
      51820 8380 22001 39531
      80 443
      # 2379 2380 6443 8472 10250
    ];
    firewall.allowedUDPPorts = [ 51820 8380 ];
  };
}
