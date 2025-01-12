

{ pkgs, config, ... }:

let
  env = path: builtins.readFile config.sops.secrets."${path}".path;
in
{

  services.xserver = {
    enable = true;
    enableTCP = true;
    # desktopManager.gnome.enable = true;

    videoDrivers = [
      "nvidia"
    ];
  };

  services.sunshine = {
    enable = true;
    autoStart = true;
    openFirewall = true;
  };


  # systemd.services.gaming-cloud = {
  #   description = "Setup windows container";
  #   wantedBy = [ "windows-lab.service" ];
  #
  #   script = ''
  #     #!${pkgs.bash}/bin/bash
  #
  #     NAMES='startup bin'
  #
  #     for NAME in $NAMES
  #     do
  #       FOLDER_PATH="/mnt/nvme-mount/gaming/config/$NAME"
  #
  #       if [ ! -d "$FOLDER_PATH" ]; then
  #         mkdir -p "$FOLDER_PATH"
  #       fi
  #     done
  #
  #     cp -f "${./docker-compose.yml}" /mnt/nvme-mount/gaming/docker-compose.yml
  #     cp -f "${./config/startup/install.bat }" /mnt/nvme-mount/gaming/config/startup/install.bat
  #   '';
  # };
  #
  # systemd.services.windows-lab = {
  #   script = ''
  #     "${pkgs.docker}/bin/docker" compose  -f /mnt/nvme-mount/gaming/docker-compose.yml up --pull always --remove-orphans --force-recreate
  #
  #   '';
  #     # docker run \
  #     # -e VERSION=10 \
  #     # -e RAM_SIZE=10G \
  #     # -e CPU_CORES=10 \
  #     # -v /mnt/nvme-mount/gaming/config/bin:/storage \
  #     # -v /mnt/nvme-mount/gaming/config/startup:/oem \
  #     # -p 8006:8006 \
  #     # -p 3389:3389/tcp \
  #     # -p 3389:3389/udp \
  #     # --restart=on-failure \
  #     # --cap-add NET_ADMIN \
  #     # --name windows \
  #     # --device=/dev/kvm \
  #     # --device nvidia.com/gpu=all \
  #     # --pull missing \
  #     # dockurr/windows
  #   # --env-file /data/coolify/source/.env
  #
  #   after = [ "docker.service" "docker.socket" ];
  #   wantedBy = [ "multi-user.target" ];
  # };
}
