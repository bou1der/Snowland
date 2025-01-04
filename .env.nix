let
  format = "yaml";
  base = {
    inherit format;
    mode = "7777";
    group = "root"; # TODO Fix this for home manager
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
    "ips/home-remote"= base;
    "ips/nix-nether"= base;
    "monero/login" = base;
    "monero/password" = base;
    "monero/address" = base;
    "home-coolify/public" = base;
    "home-coolify/private" = base;
  };
}
