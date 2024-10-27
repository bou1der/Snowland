{ config, lib, ... }:

{
  imports = [
    ./services.nix
    ./proxy.nix
    ./boot.nix
  ];


  time.timeZone = "Europe/Moscow";
  networking.hostName = "nixos";

  services.logind.powerKey = "hibernate";
  services.logind.powerKeyLongPress = "hibernate";
  services.logind.lidSwitchExternalPower = "hybrid-sleep";
  services.logind.lidSwitch = "hybrid-sleep";

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
}
