
{ pkgs, config, lib, ... }:

let
  env = path: builtins.readFile config.sops.secrets."${path}".path;
in
{
  services.gitlab-runner = {
    enable = true;
 };
}
