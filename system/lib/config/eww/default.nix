
{pkgs,...}:

let
    walls = pkgs.lib.importJSON "/home/boulder/.cache/wal/colors.json";
in

{
  programs.eww = {
    enable = false;
    configDir = ./eww-config-dir;
  };
}
