{ name, pkgs, ... }:

{
  system.stateVersion = "24.05";

  time.timeZone = "Europe/Moscow";

  services.openssh.enable = true;
  users.users.root.openssh.authorizedKeys.keys = [ ''ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCTmW5FWZnpIV3WjH73b5BiWqS4ElnTYssJHXjA6z77uwewLZkPpSCQF49XaSKtKD0KYUXcVQn6Lg3QHirB9fVwPrf0osw3de2Z14Fp/p903oeEdSpBzwPItdOr/RK7Jk3J/GLq3t8Rxt4CTTc9UiVemwooVAjMSlwqxG4X7aK1w6/WFl1OEBQKLdbhTZwKmLp0PHbx1ZJjWVixMBqXhpJO3opWHTsGOos+OyT7rtaMgWeiTEMk2aOcSmiXw9UdQD2PH/B6EeEj1/+Te22WW0fIEviPBdciRo9ZjuxscGHGgDSQ9dAqXxI0RmCFNx3KRrcAgJWDjmXB95qzmPBkNymV4qG7F9whzesq0Yss+nrhWd4CN2S0tOGXZyRaTEPqZw3l9fPXpowmYE6605NCtT++ZHc+NzfCiGi5hjmTVS5e8DGl2jRP+dQlBgjndl8pUv9+PeLRNo3XpJeTNcppkK0PO1Ep8JeNMtRacYrkUGmdTqy0vQ7ScIaXKcmjlTKRfhs= boulder@nixos'' ];
  users.defaultUserShell = pkgs.bash;

  services.tailscale.enable = true;

  virtualisation = {
    docker = {
      enable = true;
      autoPrune.enable = true;
      autoPrune.dates = "weekly";
    };
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.warn-dirty = false;

  deployment.targetHost = "46.150.174.46";
  deployment.targetUser = "root";
  deployment.buildOnTarget = true;

}
