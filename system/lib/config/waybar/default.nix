{ pkgs, ... }:

let
  walls = pkgs.lib.importJSON "/home/boulder/.cache/wal/colors.json";
in
{
  programs.waybar = {
    enable = true;
    systemd.enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        width = 1920;
        output = "eDP-1";
        # width = 2560;
        # output = "HDMI-A-1";
        margin-top = 6;
        spacing = 8;

        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "clock" ];
        modules-right = [ "tray" "custom/home-button" ];


        "hyprland/workspaces" = {
          format = "";
          all-outputs = false;
          active-only = false;
          disable-scroll = true;
          format-icons = {
            "1" = "";
            "2" = "";
            "3" = "";
            "4" = "";
            "5" = "";
            "6" = "";
            "7" = "";
          };
        };
        "tray" = {
          icon-size = 16;
          spacing = 10;

        };
        "clock" = {
          format = "{:%H:%M %a}";
          tooltip = false;
        };
        "custom/home-button" = {
          format = " ";
          tooltip = false;
        };
      };

      # secondBar = {
      #   layer = "top";
      #   position = "right";
      #   height = 550;
      #   width = 32;
      #   output = "DP-2";
      #   spacing = 8;
      #
      #   modules-left = [ ];
      #   modules-center = [ ];
      #   modules-right = [ "battery" ];
      #
      #
      #   battery = {
      #     bat = "BAT1";
      #     interval = 60;
      #     states = {
      #       warning = 30;
      #       critical = 15;
      #     };
      #     format = "{capacity}% {icon}";
      #     format-icons = [ " " " " " " " " " " ];
      #     max-length = 25;
      #   };
      #
      # };

    };

    style = ''
      * {
        font-family:Fira code;
        font-size: 12px;
      }

      window#waybar {
        background-color: ${walls.special.background};
        opacity:0.8;
      }

      window#waybar.hidden {
          opacity: 0.2;
      }

      #workspaces button {
        box-shadow: none;
        text-shadow: none;

        border-radius: 6px;

        margin:2px 4px;

        padding: 0px 6px;

        background:${walls.colors.color8};

        transition: all 0.25s cubic-bezier(.55,-0.68,.48,1.682);
      }

      #workspaces button.active {

        background:${walls.colors.color11};

        padding:0px 14px;

        margin:2px 4px;

        transition: all 0.25s cubic-bezier(.55,-0.68,.48,1.682);
      }

      #workspaces button:hover {
        background:${walls.colors.color11};

        border: none;
      }

      #workspaces {
        padding: 0px 6px;
      }

      #clock {
        font-size:14px;
        color:${walls.special.foreground};
      }

      #tray {

      }

      #custom-home-button {
        opacity:1;
        border-radius:4px;
        background-color:${walls.colors.color8};
        background-color:${walls.special.background};

        margin:2px;
        margin-right:6px;
        margin-left:6px;

        padding-left:4px;

        font-size:20px;
        color:${walls.colors.color11};
        transition: all 0.15s linear;
      }
      #custom-home-button text {
        opacity:1;

      }

      #custom-home-button:hover {
        opacity:1;
        background-color:${walls.special.foreground}
      }

    '';
  };
}
