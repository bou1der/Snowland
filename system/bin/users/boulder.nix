{ config, lib, pkgs, vars, ... }:

{
  users.users.${vars.username} = {
    isNormalUser = true;
    home = "/home/${vars.username}";
    shell = pkgs.zsh;
    ignoreShellProgramCheck = true;
    extraGroups = [ "wheel" "networkmanager" "docker" "audio" "tor" ];
  };
}
