{config, lib, ... }:

{
  imports = [
    ./services.nix
    ./proxy.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.efiSupport = true;

  # boot.extraModulePackages = with config.boot.kernelPackages;
  # [
  #   wireguard 
  # ];

  # boot.extraModprobeConfig = ''
  #   acpi_backlight=vendor
  # '';

  boot.kernelParams = [
    "acpi_backlight=vendor"
  ];

  services.libinput.enable = true;

  time.timeZone = "Europe/Moscow";
  networking.hostName = "nixos";

  services.logind.powerKey = "hibernate";
  services.logind.powerKeyLongPress = "hibernate";
  services.logind.lidSwitchExternalPower = "hybrid-sleep";
  services.logind.lidSwitch = "hybrid-sleep";

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
}
