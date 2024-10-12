
{pkgs, ...}:

{
  home.packages = with pkgs ; [
    helvum
    pavucontrol
    neofetch
    blueman
    wtwitch
    vesktop
    obs-studio
    wireguard-ui
    teamspeak_client
    telegram-desktop
    vscode
    postman
    tor-browser
    mpv
    obsidian
    yazi
    tradingview
  ];

}
