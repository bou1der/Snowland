{ ... }:

{
  system.stateVersion = "24.05"; #DONT TOUCH

  time.timeZone = "Europe/Moscow";
  networking.hostName = "nixos";

  services.logind.powerKey = "hibernate";
  services.logind.powerKeyLongPress = "hibernate";
  services.logind.lidSwitchExternalPower = "hybrid-sleep";
  services.logind.lidSwitch = "hybrid-sleep";


  programs.nix-ld.enable = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nix.settings.warn-dirty = false;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

}
