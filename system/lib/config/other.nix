{ pkgs, nixpkgs, ... }:

{
  home.packages = with pkgs ; [
    helvum
    spotify
    pavucontrol
    neofetch
    blueman
    vesktop
    obs-studio
    ani-cli
    libreoffice-qt
    prismlauncher
    telegram-desktop
    beekeeper-studio
    google-chrome
    monero-gui
    sunshine
    moonlight-qt
    winbox4
    vscode
    postman
    tor-browser
    mpv
    obsidian
    yazi
    tradingview
    bitwarden-desktop
    krita
    # steam
    osu-lazer-bin
  ];
  nixpkgs.config.permittedInsecurePackages = [
    "beekeeper-studio-5.1.5"
    "ventoy-1.1.05"
  ];


}
