{ pkgs, ... }:

{
  imports = [
    ./hyprlock.nix
    ./hyprpaper.nix
    ./hypridle.nix
  ];

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config = {
      common.default = [ "gtk" ];
      hyprland.default = [
        "gtk"
        "hyprland"
      ];
    };

    configPackages = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-wlr
      pkgs.xdg-desktop-portal-gtk
    ];

    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-wlr
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  wayland.windowManager.hyprland = {

    enable = true;
    xwayland.enable = true;

    portalPackage = pkgs.xdg-desktop-portal-hyprland;

    settings = {

      monitor = [
        # "HDMI-A-1, 2560x1080@60, -1920x0, 1"
        "eDP-1,1920x1200@60, 0x0, 1"
        # "DP-2,1920x550@60, 0x1200, 1"
        # "eDP-1, disable"
        "DP-2, disable"
      ];

      "$mod" = "SUPER";
      "$term" = "kitty";
      bind = [
        "$mod, Return, exec, $term"
        "$mod, Backspace, killactive"
        "$mod  Escape, M, exit"
        "$mod, Space, togglefloating"

        "$mod, Escape, exec, ~/.config/home-manager/scripts/show-rofi.sh"
        "$mod SHIFT, p, exec, rofi -config ~/.config/rofi/ssh.rasi -parse-known-host -show-icons -show ssh -p '🐢' -yoffset 800 "
        "$mod, p, exec, zsh -c 'proxychains4 $(rofi -config ~/.config/rofi/proxy.rasi -dmenu -p '🐢' -yoffset 800)' "

        "$mod, f, fullscreen"

        "$mod SHIFT, A, exec, hyprshot -m region --clipboard-only -z"
        "$mod ALT, l, exec, hyprlock --immediate & disown & systemctl suspend "

        "$mod, h, movefocus, l"
        "$mod, l, movefocus, r"
        "$mod, k, movefocus, u"
        "$mod, j, movefocus, d"

        "$mod SHIFT, h, workspace, e-1"
        "$mod SHIFT, l, workspace, e+1"

        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"

        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"

        "$mod, S, togglespecialworkspace, magic"
        "$mod SHIFT, S, movetoworkspace, special:magic"
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
      ];

      animations = {
        # animation=NAME,ONOFF,SPEED,CURVE[,STYLE]
        enabled = true;
        # bezier = "myAnim,0.67,0,0.39,0.99";
        bezier = "myAnim,0.05,0.9,0.1,1.05";
        animation = [
          "windows, 1, 2, myAnim, slide"
          "workspaces,1, 5,myAnim, slide"
          "specialWorkspace,1 ,4,myAnim,slide"
        ];
      };

      input = {
        "kb_layout" = "us,ru";
        "kb_options" = "grp:alt_shift_toggle";
        "repeat_rate" = 33;
        "repeat_delay" = 250;
        "follow_mouse" = 1;

        touchpad = {
          "natural_scroll" = true;
        };

      };

      xwayland = {
        "force_zero_scaling" = true;
      };

      source = "~/.cache/wal/templates/hypr.conf";

      general = {
        gaps_in = 2;
        gaps_out = 7;
        border_size = 2;
        resize_on_border = true;
        allow_tearing = true;
        layout = "dwindle";

        # "col.active_border" = "rgba(" + walls.colors.color1 + ")" ;
        # "col.inactive_border" = "$color0";
      };

      decoration = {
        rounding = 6;
        # drop_shadow = false;
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          vibrancy = 0.1696;
        };
      };

      # TODO Настроить свайпы
      gestures = {
        workspace_swipe = true;
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      # windowrule = [
      #   "opacity[0.5] ^(dunst)$"
      # ];

    };
  };

}
