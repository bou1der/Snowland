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
    gobuster
    colmena
    openssl
    evtest
    ventoy
    cargo
    pywal
    btop
    nmap
    tree
    deno
    tmux
  ];
}
