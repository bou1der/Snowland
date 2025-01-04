{ pkgs, lib, ... }:

let
  key = secret: "${builtins.readFile secret}";
in
{
  systemd.services.coolify-prepare-files = {
    description = "Setup files for coolify";
    wantedBy = [ "coolify.service" ];
    wants = [ "data-coolify.mount" ];

    script = ''
      #!${pkgs.bash}/bin/bash
      NAMES='source ssh applications databases backups services proxy webhooks-during-maintenance ssh/keys ssh/mux proxy/dynamic'

      for NAME in $NAMES
      do
        FOLDER_PATH="/data/coolify/$NAME"

        if [ ! -d "$FOLDER_PATH" ]; then
          mkdir -p "$FOLDER_PATH"
        fi
      done

      cp -f "${./config/docker-compose.yml}" /data/coolify/source/docker-compose.yml
      cp -f "${./config/docker-compose.prod.yml}" /data/coolify/source/docker-compose.prod.yml
      cp -f "${./config/upgrade.sh}" /data/coolify/source/upgrade.sh
      cp -f "${/home/boulder/Snowland/.env/coolify}" /data/coolify/source/.env

      if [ ! -f "/data/coolify/ssh/keys/id.root@host.docker.internal" ]; then
        echo "${key /home/boulder/Snowland/.env/sshkeys/coolify-localhost.pub}" >  /data/coolify/ssh/keys/id.root@host.docker.internal.pub
        echo "${key /home/boulder/Snowland/.env/sshkeys/coolify-localhost}" >  /data/coolify/ssh/keys/id.root@host.docker.internal
      fi


      chown -R 9999:root /data/coolify
      chmod -R 700 /data/coolify
    '';
  };

  systemd.services.coolify = {
    script = ''
      "${pkgs.docker}/bin/docker" compose --env-file /data/coolify/source/.env -f /data/coolify/source/docker-compose.yml -f /data/coolify/source/docker-compose.prod.yml up --pull always --remove-orphans --force-recreate
    '';
    after = [ "docker.service" "docker.socket" ];
    wantedBy = [ "multi-user.target" ];
  };
}

