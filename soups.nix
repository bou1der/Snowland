
{pkgs, soup-module, config, vars, ...}:

let
  env = import ./.env.nix;
  secrets = env.secrets;
in
{
  imports = [
    soup-module
  ];

  sops = {
    defaultSopsFile = ./.sops.yaml;
    defaultSopsFormat = env.format;
    age.keyFile = "/home/${vars.username}/Snowland/.keys";

    inherit secrets;
  };
}
