{ pkgs, ... }:

{
  home.packages = with pkgs; [
    wireguard-tools
    speedtest-cli
    clang-tools
    alacritty
    inetutils
    sysbench
    hyprshot
    gobuster
    nest-cli
    colmena
    pnpm

    helmfile
    kubernetes-helm
    kubernetes
    kubectl
    minikube

    android-studio

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
    sops
    age
  ];

}
