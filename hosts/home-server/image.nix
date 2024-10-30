{ pkgs, lib, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./bin
  ];
}
