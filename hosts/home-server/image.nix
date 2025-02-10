{pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./bin
    ./services
    ../soups.nix
    ../cluster
 ];

  config.cluster = {
    enable = true;
    role = "master";
  };




}
