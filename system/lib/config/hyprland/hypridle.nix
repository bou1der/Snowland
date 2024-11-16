{ pkgs, config, lib, ... }:

{
  services.hypridle = {
    enable = true;
    package = pkgs.hypridle;
  };

  services.hypridle.settings = {
    general = {
      after_sleep_cmd = "hyprctl dispatch dpms on";
      ignore_dbus_inhibit = false;
      lock_cmd = "hyprlock";
    };

    listener = [
      # {
      #   timeout = 60;                                # 2.5min.
      #   on-timeout = "brightnessctl -s set 10";         # set monitor backlight to minimum, avoid 0 on OLED monitor.
      #   on-resume = "brightnessctl -r";                 # monitor backlight restore.
      # }
      {
        timeout = 360;
        on-timeout = "hyprlock --immediate & disown & systemctl suspend";
      }
    ];
  };
}
