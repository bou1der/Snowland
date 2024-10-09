
{ config, lib, pkgs, ... }:

{

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    fira-code
    fira-code-symbols
    liberation_ttf
    siji
    nerdfonts
  ];  

}
