
{ pkgs, config, lib, ... }:

{

  home.packages = with pkgs ; [
    hyprpaper
    waypaper
  ];

  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      splash_offset = 2.0;

      preload = [ "~/.config/.current-wallpaper" "~/.config/.current-wallpaper" ];

      wallpaper = [
        "eDP-1,~/.config/.current-wallpaper"
        "DP-2,~/.config/.current-wallpaper"
      ];
    };
  };
}
