{ ... }:

{
  imports = [
    ./proxy.nix
  ];

  networking.firewall.enable = true;
  networking.firewall.allowPing = true;
  networking.firewall.allowedUDPPorts = [
    8081
  ];

  networking.firewall.allowedTCPPorts = [
    8081
    8000
    3000
    3001
  ];

  environment.etc = {
    "resolv.conf".text = ''
      nameserver 208.67.222.222
      nameserver 208.67.220.220
    '';
  };

  networking.nameservers = [
    "208.67.222.222"
    "208.67.220.220"
  ];

  networking.wireless = {
    iwd = {
      enable = true;
    };
    iwd.settings = {
      Network = {
        EnableIPv6 = true;
        NameResolvingService = "systemd-resolved";
      };
    };

  };

}
