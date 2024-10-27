{ config, lib, pkgs, ... }:

{

  networking.firewall.enable = true;
  # networking.firewall.allowedUDPPorts = [ 51820 ];


  # networking.wireguard.enable = false;
  # networking.wireguard.interfaces = {
  #   wg0 = {
  #     ips = [ "10.100.0.2/24" ];
  #     privateKeyFile = "/home/boulder/Snowland/.env/wirekeys/private";
  #
  #     peers = [
  #       {
  #         publicKey = "CZ2lo0fKVGFHFyJmhPqBbt+NVrLVnenpI1czyWl44xA=";
  #
  #         allowedIPs = [ "0.0.0.0/0" ];
  #         endpoint = "90.156.253.98:51820";
  #
  #         persistentKeepalive = 25;
  #       }
  #     ];
  #   };
  # };

  networking.networkmanager = {
    enable = true;
    dns = "systemd-resolved";
    insertNameservers = [ "208.67.222.222" "208.67.220.220" ];
  };

}
