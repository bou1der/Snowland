{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    speedtest-cli
    nodejs_22
    openssl
    openssh
    btop
    jdk
    git
    tmux
    bun
  ];
}
