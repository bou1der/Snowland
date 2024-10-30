{ pkgs, lib, ... }:

{
  imports = [
    ./networking
    ./system
    ./common.nix
    ./ssh.nix
  ];
}
