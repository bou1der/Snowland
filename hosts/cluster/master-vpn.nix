
{ lib, config, pkgs, ... }:

let 
  cfg = config.cluster;
  env = path: builtins.readFile config.sops.secrets."${path}".path;
in
{

  services.headscale = if cfg.role == "master" then {
    enable = true;
    address = "0.0.0.0";
    port = 9090;
    user = "root";
    settings = {
      policy.path = ./config/acls.json;
      server_url = "https://tail.booulder.xyz:9090";
      dns = {
        base_domain = "booulder.xyz";

        # magic_dns = true;
        # domains = ["tail.booulder.xyz"];

        # nameservers.global = [
        #   "1.1.1.1"
        #   "9.9.9.9"
        # ];
      };
      ip_prefixes = [
        "10.1.0.0/10"
      ];
      logtail.enabled = false;
      log.level = "debug";
    };
  } else {};

  # services.caddy = if cfg.role == "master" then {
  #   enable = true;
  #
  #   virtualHosts."tail.booulder.xyz".extraConfig = ''
  #     reverse_proxy * 127.0.0.1:9090
  #   '';
  # } else {};
}
