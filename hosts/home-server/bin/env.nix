{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nvidia-container-toolkit
    libnvidia-container
    speedtest-cli
    nodejs_22
    pciutils
    openssl
    openssh
    btop
    jdk
    git
    tmux
    bun
  ];
}
