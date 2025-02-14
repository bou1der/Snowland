let
  format = "yaml";
  base = {
    inherit format;
    mode = "7777";
    # group = "root"; # TODO Fix this for home manager
    sopsFile = ./env.yaml;
  };
in
{
  inherit format;
  secrets = {
    "git/name" = base;
    "git/email" = base;
    "git/token" = base;

    "ips/home-local" = base;
    "ips/home-domain" = base;
    "ips/home-remote"= base;
    "ips/nix-nether"= base;

    "monero/login" = base;
    "monero/password" = base;
    "monero/address" = base;

    "home-coolify/public" = base;
    "home-coolify/private" = base;

    "shadowsocks/password" = base;

    "wireguard/private" = base;

    "wireguard/boulder-phone" = base;
    "wireguard/boulder-pc" = base;
    "wireguard/boulder-laptop" = base;
    "wireguard/boulder-preshared" = base;

    "wireguard/xelo-phone" = base;
    "wireguard/xelo-laptop" = base;
    "wireguard/xelo-pc" = base;

    "wireguard/shipownik-mobile" = base;
    "wireguard/shipownik-pc" = base;

    "wireguard/yzifbro-pc" = base;
    "wireguard/yzifbro-mobile" = base;
    "wireguard/yzifbro-tablet" = base;

    "k8s/master-ip" = base;
    "k8s/server-token" = base;

    "vpn/domain" = base;
    "vpn/apikey" = base;
  };
}
