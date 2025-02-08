{ config, ... }:
{
  imports = [
    ./services
    ./hardware-configuration.nix
    ./bin
    ../soups.nix
    ../cluster.nix
  ];

  config.cluster = {
    enable = false;
    role = "node";
  };

}
