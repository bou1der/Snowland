{ name, pkgs, config, ... }:

let
  env = path: builtins.readFile config.sops.secrets."${path}".path;
in
{
  system.stateVersion = "24.05";

  time.timeZone = "Europe/Moscow";

  services.openssh.enable = true;
  users.defaultUserShell = pkgs.bash;

  # services.tailscale.enable = true;

  virtualisation = {
    docker = {
      enable = true;
      autoPrune.enable = true;
      autoPrune.dates = "weekly";
    };
    oci-containers.backend = "docker";
  };

  systemd.services.prepare-docker = {
    description = "Prepare docker settings";
    script = ''
      # coolify
      ${pkgs.docker}/bin/docker  network inspect coolify >/dev/null 2>&1 || \
      ${pkgs.docker}/bin/docker network create -attachable coolify

      # host
      # ${pkgs.docker}/bin/docker  network inspect local >/dev/null 2>&1 || \
      # ${pkgs.docker}/bin/docker network create --driver host local
    '';
    after = [ "docker.service" "docker.socket" ];
    wantedBy = [ "multi-user.target" ];
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.warn-dirty = false;


  deployment.targetHost = env "ips/home-local";
  deployment.targetUser = "root";
  deployment.targetPort = 22001;
  deployment.buildOnTarget = true;
}
