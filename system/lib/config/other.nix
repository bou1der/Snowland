{ pkgs, ... }:

{
  home.packages = with pkgs ; [
    helvum
    spotify
    pavucontrol
    neofetch
    blueman
    wtwitch
    vesktop
    obs-studio
    ani-cli
    libreoffice-qt
    prismlauncher
    teamspeak_client
    telegram-desktop
    beekeeper-studio
    google-chrome
    # virtualbox
    monero-gui
    monero-cli
    vscode
    postman
    tor-browser
    age
    sops
    mpv
    obsidian
    yazi
    tradingview
  ];


}
