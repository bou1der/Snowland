
{pkgs, soup-module, config, lib, ...}:

let
  env = import ../.env.nix;
  secrets = env.secrets;
in
{
  imports = [
    soup-module
  ];

  sops = {
    defaultSopsFile = ../.sops.yaml;
    defaultSopsFormat = env.format;
    age.keyFile = "/etc/.secret.key";

    inherit secrets;
  };

}
