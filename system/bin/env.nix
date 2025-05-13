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
    go
    gcc
    ta-lib
    docker
    poppler-utils
    docker-compose
    bridge-utils
    libnotify
    poppler-utils
    glibc
    musl
    ios-webkit-debug-proxy
    ios-safari-remote-debug
    libimobiledevice
    usbmuxd
    nix-ld
    kdePackages.xwaylandvideobridge
  ];

  environment.variables = {
    SOPS_AGE_KEY_FILE = "$HOME/Snowland/.keys";
    # LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib";
  };

}
