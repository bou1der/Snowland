{ config, lib, pkgs, ... }:

let
  walColors = pkgs.lib.importJSON "${pkgs.filesystem.path}/home/boulder/.cache/wal/colors.json";
in
{

  imports = [
    ./lib
  ];

  nixpkgs.config.allowUnfree = true;

  home = {

    file.".current-wallpaper".text = ''
      ~/.config/.current-wallpaper
    '';
  };


  programs = {
    bash = {
      enable = true;
      shellAliases = {
        nixsw = "sudo nixos-rebuild switch --flake .#boulder --impure";
        homesw = "nix build .#hmConfig.boulder.activationPackage --impure";
      };
    };

  };
}
