{ nixpkgs, pkgs, lib, config, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.efiSupport = true;


  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.legacy_340;
    modesetting.enable = true;

    powerManagement.enable = false;
    powerManagement.finegrained = false;

    open = false;

    nvidiaSettings = true;
  };
}
