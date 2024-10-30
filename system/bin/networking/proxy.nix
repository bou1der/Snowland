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
      PL = {
        enable = true;
        type = "socks4";
        host = "185.32.4.65";
        port = 4153;
      };
    };
  };

  services.tor = {
    enable = true;
    openFirewall = true;
    client.enable = true;
  };

}
