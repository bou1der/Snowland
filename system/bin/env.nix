{ pkgs, ... }:

{
  services.libinput.enable = true;
  services.acpid.enable = true;

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    fira-code
    fira-code-symbols
    liberation_ttf
    siji
    nerd-fonts.hack

  ];

  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    tor
    docker
    docker-compose
    bridge-utils
    libnotify
    xwaylandvideobridge
  ];
}
