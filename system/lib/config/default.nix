{ pkgs, nixvim, ... }:
{
  home.packages = with pkgs; [
     (nixvim.legacyPackages."${pkgs.stdenv.hostPlatform.system}".makeNixvimWithModule {
      inherit pkgs;
      module = import ./nvim;
    })
  ];

  imports = [
    ./kitty
    ./cava
    ./rofi
    ./dunst
    ./hyprland
    ./firefox
    ./waybar
    ./other.nix
    ./tmux
    ./zathura
  ];
}

