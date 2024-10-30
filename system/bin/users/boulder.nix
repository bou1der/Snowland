{ config, lib, pkgs, ... }:

{
  users.users.boulder = {
    isNormalUser = true;
    home = "/home/boulder";
    shell = pkgs.zsh;
    ignoreShellProgramCheck = true;
    extraGroups = [ "wheel" "networkmanager" "docker" "audio" "tor" ];
  };
}
