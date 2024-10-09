
{pkgs,...}:

let
    walls = pkgs.lib.importJSON "/home/boulder/.cache/wal/colors.json";
in

{
  services.dunst = {
    enable = true;
    settings = {
      global = {
        monitor = 1;
        width = 250;
        height = 350;
        origin = "bottom-right";
        offset = "20x30";
        font = "Fira Code 12";
        min_icon_size = 64;

        progress_bar = true;
        progress_bar_height = 20;
        follow = "mouse";
        corner_radius = 4;
      };
      urgency_normal = {
        background = walls.special.background;
        foreground = walls.special.foreground;
        timeout = 7;
      };
    };
  };
}
