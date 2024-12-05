{ name, pkgs, ... }:

{
  system.stateVersion = "24.05";

  time.timeZone = "Europe/Moscow";

  services.openssh.enable = true;
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


  deployment.targetHost = "192.168.88.252";
  deployment.targetUser = "root";
  deployment.targetPort = 22001;
  deployment.buildOnTarget = true;
}
