{ pkgs, ... }:

{
  home.packages = with pkgs ; [
    wireguard-tools
    speedtest-cli
    clang-tools
    monero-cli
    alacritty
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
    sops
    age
  ];
}
