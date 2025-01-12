
{ config, pkgs, ... }:

let
  env = path: builtins.readFile config.sops.secrets."${path}".path;
in
{

  services.shadowsocks = {
    enable = true;
    port = 8380;
    password = env "shadowsocks/password"; 

    extraConfig = {
      nameserver = "8.8.8.8";
    };
  };
  
}
