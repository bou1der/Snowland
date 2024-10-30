
{pkgs,...}:

let
    walls = pkgs.lib.importJSON "/home/boulder/.cache/wal/colors.json";
in

{
  programs.eww = {
    enable = true;
    configDir = ./eww-config-dir;
  };
}
