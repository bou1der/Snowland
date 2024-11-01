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
    openssl
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
