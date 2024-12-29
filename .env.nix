let
  format = "yaml";
  base = {
    inherit format;
    mode = "0440";
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
  };
}
