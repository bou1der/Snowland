{ config, vars, pkgs, ... }:


let
  env = path: builtins.readFile config.sops.secrets."${path}".path;
  color = pkgs.lib.importJSON "/home/${vars.username}/.cache/wal/colors.json";
in
{

  programs.oh-my-posh = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      final_space = true;
      version = 3;
      blocks = [
        {
          type = "prompt";
          "alignment" = "left";
          "segments" = [
            {
              "type" = "path";
              "style" = "powerline";
              "max_depth" = 3;
              "powerline_symbol" = "";
              "foreground" = color.special.background;
              "background" = color.special.foreground;
              "properties" = {
                "style" = "folder";
              };
            }
            {
              "type" = "git";
              "style" = "powerline";
              "powerline_symbol" = "";
              "invert_powerline" = false;
              "foreground" = color.special.foreground;
              "background" = color.colors.color1;
              "leading_diamond" = "";
              "trailing_diamond" = "";
              "properties" = {
                "fetch_status" = true;
                "fetch_upstream_icon" = true;
                "source" = "cli";
              };
            }
          ];
        }
        {

          type = "prompt";
          "alignment" = "right";
          "segments" = [
            {
              "type" = "battery";
              "style" = "powerline";
              "powerline_symbol" = " ";
              "foreground" = color.special.background;
              "background" = color.special.foreground;
              "background_templates" = [
                "{{if eq \"Discharging\" .State.String}}#ab0000{{end}}"
              ];
              "template" = " {{ if not .Error }}{{ .Icon }}{{ .Percentage }}{{ end }} ";
              "properties" = {
                "discharging_icon" = "󰂍 ";
                "charging_icon" = " ";
                "charged_icon" = " ";
              };
            }
          ];
        }
      ];
    };
  };

}






