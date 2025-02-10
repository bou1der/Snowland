{ config, ... }:
{
  imports = [
    ./services
    ./hardware-configuration.nix
    ./bin
    ../soups.nix
    ../cluster
  ];

  config.cluster = {
    enable = true;
    role = "node";
    name = "nix-nether";
  };
}
