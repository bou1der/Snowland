{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    wireguard-tools
    speedtest-cli
    nodejs_22
    openssl
    openssh
    btop
    jdk
    git
    tmux
  ];
}
