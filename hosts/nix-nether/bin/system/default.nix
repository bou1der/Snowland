{ pkgs, config, lib, ... }:

{
  # boot.loader.systemd-boot.enable = true;
  # boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.device = "nodev";
  # boot.kernel.sysctl = {
  #   "net.ipv4.ip_forward" = 1;
  # };
  # boot.loader.grub.efiSupport = true;
}
