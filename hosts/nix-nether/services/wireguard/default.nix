
{ config, pkgs, ... }:

let
  env = path: builtins.readFile config.sops.secrets."${path}".path;
in
{

  networking = {
    nat.enable = true;
    nat.externalInterface = "ens3";
    nat.internalInterfaces = [ "wg0" ];
    
    firewall = {
      enable = true;              
      allowedTCPPorts = [ 22001 ];
      allowedUDPPorts = [ 51820 ];

      extraCommands = ''
        iptables -t nat -A POSTROUTING -s 10.100.0.0/24 -o ens3 -j MASQUERADE
      '';
    };

    wireguard.interfaces = {
      wg0 = {
        ips = [ "10.100.0.1/24" ];
        listenPort = 51820;
        privateKey = env "wireguard/private";

        peers = [
          {
            publicKey = env "wireguard/boulder-phone";
            allowedIPs = ["10.100.0.101/32"];
          }
          {
            publicKey = env "wireguard/boulder-laptop";
            allowedIPs = ["10.100.0.102/32"];
          }
          {
            publicKey = env "wireguard/boulder-pc";
            allowedIPs = ["10.100.0.103/32"];
          }
          {
            publicKey = env "wireguard/xelo-phone";
            allowedIPs = ["10.100.0.104/32"];
          }
          {
            publicKey = env "wireguard/xelo-pc";
            allowedIPs = ["10.100.0.105/32"];
          }
          {
            publicKey = env "wireguard/xelo-laptop";
            allowedIPs = ["10.100.0.106/32"];
          }
          {
            publicKey = env "wireguard/shipownik-mobile";
            allowedIPs = ["10.100.0.107/32"];
          }
          {
            publicKey = env "wireguard/shipownik-pc";
            allowedIPs = ["10.100.0.108/32"];
          }
          {
            publicKey = env "wireguard/yzifbro-pc";
            allowedIPs = ["10.100.0.109/32"];
          }
          {
            publicKey = env "wireguard/yzifbro-mobile";
            allowedIPs = ["10.100.0.110/32"];
          }
          {
            publicKey = env "wireguard/yzifbro-tablet";
            allowedIPs = ["10.100.0.111/32"];
          }
        ];
      };
    };
  };
  
}
