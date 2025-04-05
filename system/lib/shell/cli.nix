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

    helmfile
    kubernetes-helm
    kubernetes
    kubectl
    minikube
    pnpm

    tailscale
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
