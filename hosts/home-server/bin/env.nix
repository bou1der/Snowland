{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    speedtest-cli
    nodejs_22
    openssl
    btop
    jdk
    git
    bun
  ];
}
