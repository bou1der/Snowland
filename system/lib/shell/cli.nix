{ pkgs, ... }:

{
  home.packages = with pkgs ; [
    wireguard-tools
    clang-tools
    alacritty
    speedtest-cli
    inetutils
    sysbench
    hyprshot
    colmena
    evtest
    ventoy
    cargo
    pywal
    btop
    nmap
    tree
    tmux
  ];
}
