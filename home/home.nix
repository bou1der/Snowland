
{config, lib, pkgs, ...}:

let
    walColors = pkgs.lib.importJSON "${pkgs.filesystem.path}/home/boulder/.cache/wal/colors.json";
in
{

  imports = [
    ./lib
  ];

  # programs.yandex-music.enable = true;
  # programs.yandex-music.tray.enable = true; # to enable tray support

  home = {


    file.".current-wallpaper".text = ''
      ~/.config/.current-wallpaper
    '';
  };

  nixpkgs.config.allowUnfree = true;

  programs = {
  #   fish = {
  #     enable = true;
  #     shellAliases = {
  #      nixsw = "sudo nixos-rebuild switch";
  #       homesw = "home-manager switch";
  #     };
  #   };
    bash = {
      enable = true;
      shellAliases = {
        nixsw = "sudo nixos-rebuild switch --flake .#boulder --impure";
        homesw = "nix build .#hmConfig.boulder.activationPackage --impure";
      };
    };

  };
}
