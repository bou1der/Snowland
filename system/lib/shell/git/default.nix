{ pkgs, lib, config, ... }:

let
  env = path: builtins.readFile config.sops.secrets."${path}".path;
in
{
  programs.git = {
    enable = true;
    userEmail = env "git/email";
    userName = env "git/name";

    extraConfig = {
      credential.helper = "store";
    };
  };
}
