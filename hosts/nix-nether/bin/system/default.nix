{ pkgs, lib, ... }:

{
  # boot.loader.systemd-boot.enable = true;
  # boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.device = "nodev";
  # boot.loader.grub.efiSupport = true;
}
