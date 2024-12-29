let
  format = "yaml";
  base = {
    inherit format;
    mode = "0440";
    group = "root";
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
    "monero/login" = base;
    "monero/password" = base;
  };
}
