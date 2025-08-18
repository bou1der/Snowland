{ ... }:

{
  programs.proxychains = {
    enable = true;
    proxyDNS = true;
    chain.type = "dynamic";
    proxies = {
      torProxy = {
        enable = true;
        type = "socks5";
        host = "127.0.0.1";
        port = 9050;
      };
    };
  };

  services.tor = {
    enable = true;
    openFirewall = true;
    client.enable = true;
  };

  services.tailscale = {
    enable = false;
    openFirewall = true;
    useRoutingFeatures = "client";
    extraUpFlags = [ "--ssh" ];
  };

}
