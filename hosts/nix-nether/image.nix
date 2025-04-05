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
    enable = false;
    role = "node";
    name = "nix-nether";
    ip = "10.0.0.1/32";
  };
}
