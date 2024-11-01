{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    speedtest-cli
    nodejs_22
    jdk
  ];
}
