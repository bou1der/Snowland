{lib, config, pkgs, ...}:

let 
  cfg = config.cluster;
  env = path: builtins.readFile config.sops.secrets."${path}".path;
in
{

}
