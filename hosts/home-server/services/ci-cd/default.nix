{ pkgs, config, lib, ... }:

let
  env = path: builtins.readFile config.sops.secrets."${path}".path;
in
{
  imports = [
    ./runner.nix
  ];

  systemd.services.prepare-traefik = {
    description = "Prepare traefik settings";
    script = ''
      #!${pkgs.bash}/bin/bash
      DOMAIN='${env "ips/home-domain"}'
      CERTS='registry'

      for CERT in $CERTS
      do
        FOLDER_PATH="/var/lib/certs/$CERT"

        if [ ! -d "$FOLDER_PATH" ]; then
          mkdir -p "$FOLDER_PATH"
          openssl req -x509 -newkey rsa:2048 -keyout $FOLDER_PATH/$CERT.$DOMAIN.key -out $FOLDER_PATH/$CERT.$DOMAIN.crt -days 365 -nodes -subj '/CN=$CERT.$DOMAIN'
        fi
      done

      if [ ! -d "/data/coolify/proxy" ]; then
        mkdir -p "/data/coolify/proxy"
      fi

      cp -f "${./config/traefik.yaml}" /data/coolify/proxy/traefik.yaml
    '';
    wantedBy = [ "docker-traefik.service" ];
  };

  virtualisation.oci-containers.containers = {
    traefik = {
      user = "root:root";
      image = "traefik:v3.1";
      autoStart = true;

      ports = [
        "80:80"
        "443:443"
        "443:443/udp"
        "8080:8080"
      ];
      volumes = [
        "/var/run/docker.sock:/var/run/docker.sock"
        "/data/coolify/proxy:/traefik"
        # "/var/lib/certs:/certs"
      ];
      networks = [
        "host"
      ];

      cmd = [
        "--ping=true"
        "--ping.entrypoint=http"
        "--api.dashboard=true"
        "--entrypoints.http.address=:80"
        "--entrypoints.https.address=:443"
        "--entrypoints.git.address=:9418"
        "--entrypoints.http.http.encodequerysemicolons=true"
        "--entryPoints.http.http2.maxConcurrentStreams=50"
        "--entrypoints.https.http.encodequerysemicolons=true"
        "--entryPoints.https.http2.maxConcurrentStreams=50"
        "--entrypoints.https.http3"
        "--providers.file.filename=/traefik/traefik.yaml"
        "--providers.docker.exposedbydefault=false"
        "--providers.file.watch=true"
        "--certificatesresolvers.letsencrypt.acme.httpchallenge=true"
        "--certificatesresolvers.letsencrypt.acme.httpchallenge.entrypoint=http"
        "--certificatesresolvers.letsencrypt.acme.storage=/traefik/acme.json"
        "--api.insecure=false"
        "--providers.docker=true"
      ];
    };
  };


  services.gitlab = {
    enable = true;
    https = true;
    host = "gitlab.${env "ips/home-domain"}";
    port = 443;

    registry = {
      enable = true;
      host = "registry.${env "ips/home-domain"}";
      certFile = "/var/lib/certs/registry/registry.${env "ips/home-domain"}.crt";
      keyFile = "/var/lib/certs/registry/registry.${env "ips/home-domain"}.key";
      externalAddress = "registry.${env "ips/home-domain"}";
      externalPort = 5000;
      port = 5000;
    };

    initialRootPasswordFile = "/run/secrets/gitlab/password";
    secrets =  {
      secretFile = "/run/secrets/gitlab/secret";
      dbFile = "/run/secrets/gitlab/secret-db";
      otpFile = "/run/secrets/gitlab/secret-otp";
      jwsFile = "/run/secrets/gitlab/secret-jws";
    };
  };

  services.nginx = {
    enable = true;
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    httpConfig = ''
      client_max_body_size 500M;
      server {
        listen 0.0.0.0:2424 ;
        listen [::0]:2424 ;
        server_name localhost ;
        location / {
          proxy_pass http://unix:/run/gitlab/gitlab-workhorse.socket;
        }
      }
    '';

    virtualHosts = {
      localhost = {
        locations."/".proxyPass = "http://unix:/run/gitlab/gitlab-workhorse.socket";
      };
    };
  };
  
}
