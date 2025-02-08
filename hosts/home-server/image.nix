{
  imports = [
    ./hardware-configuration.nix
    ./bin
    ./services
    ../soups.nix
    ../cluster.nix
 ];

  config.cluster = {
    enable = true;
    role = "master";
  };

}
