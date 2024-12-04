{ pkgs, ... }:

let
  walls = pkgs.lib.importJSON "/home/boulder/.cache/wal/colors.json";
in
{
  programs.cava = {
    enable = false;

    settings = {
      general.mode = "waves";
      general.framerate = 46;
      general.autosens = 1;

      input.method = "pipewire";
      input.source = "auto";

      color = {
        gradient = 1;

        gradient_color_1 = "'${walls.colors.color1}'";
        gradient_color_2 = "'${walls.colors.color2}'";
        gradient_color_3 = "'${walls.colors.color3}'";
        gradient_color_4 = "'${walls.colors.color4}'";
        gradient_color_5 = "'${walls.colors.color5}'";
        gradient_color_6 = "'${walls.colors.color6}'";
        gradient_color_7 = "'${walls.colors.color7}'";
        gradient_color_8 = "'${walls.colors.color8}'";



      };
    };
  };
}
