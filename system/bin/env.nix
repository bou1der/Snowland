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
    gcc
    ta-lib
    docker
    docker-compose
    bridge-utils
    libnotify
    xwaylandvideobridge
  ];

  environment.variables = {
    SOPS_AGE_KEY_FILE = "$HOME/Snowland/.keys";
    LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib";
    TA_INCLUDE_PATH = "${pkgs.ta-lib}/include";
    TA_LIBRARY_PATH = "${pkgs.ta-lib}/lib";

  };

}
