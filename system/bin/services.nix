{ config, lib, ... }:

{
  services.libinput.enable = true;
  services.acpid.enable = true;

  services.tor = {
    enable = true;
    openFirewall = true;
    client.enable = true;
  };
}
