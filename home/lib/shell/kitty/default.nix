{config, lib, pkgs, ...}:

let
    walls = pkgs.lib.importJSON "/home/boulder/.cache/wal/colors.json";
in
{

  programs.kitty = {
    enable = true;

    font.name = "FiraCode Nerd Font";
    font.size = 12;

    settings={
      include-file = "$HOME/.cache/wal/colors-kitty.conf";

      foreground = walls.special.foreground;
      background = walls.special.background;
      background_opacity = "0.75";

      background_blur = "0"; 
      background_image = "~/.config/.kitty-bg.png";
      background_image_layout = "centered";

      background_image_linear =  "yes";
      confirm_os_window_close = "0";

      color1 = walls.colors.color1;
      color2 = walls.colors.color2;
      color3 = walls.colors.color3;
      color4 = walls.colors.color4;
      color5 = walls.colors.color5;
      color6 = walls.colors.color6;
      color7 = walls.colors.color7;
      color8 = walls.colors.color8;
      color9 = walls.colors.color8;
      color10 = walls.colors.color10;
      color11 = walls.colors.color11;
      color12 = walls.colors.color12;
      color13 = walls.colors.color13;
      color14 = walls.colors.color14;
      color15 = walls.colors.color15;

      cursor = "#ab0000";
      cursor_shape = "block";
      cursor_blink_interval = "0.25";

      allow_hyperlinks = "yes";
      detect_urls = "yes";

      mouse_hide_wait = "1.5";
      url_style = "curly";

      enable_audio_bell = "no";
      visual_bell_color = "#ab0000";
      visual_bell_duration = "0.4";
    };
  };

}
