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
    nest-cli
    colmena
    openssl
    wg-bond
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
