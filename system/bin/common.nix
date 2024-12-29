{ config, ... }:

let
  env = path: builtins.readFile config.sops.secrets."${path}".path;
in
{
  system.stateVersion = "24.05"; #DONT TOUCH

  time.timeZone = "Europe/Moscow";
  networking.hostName = "nixos";

  services.logind.powerKey = "hibernate";
  services.logind.powerKeyLongPress = "hibernate";
  services.logind.lidSwitchExternalPower = "hybrid-sleep";
  services.logind.lidSwitch = "hybrid-sleep";


  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
    autoPrune.enable = true;
    autoPrune.dates = "weekly";
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.warn-dirty = false;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  services.monero = {
    enable = true;
    mining.enable = false;

    rpc = {
      address = env "ips/home-local";
      port = 18081;
    };
  };
}
