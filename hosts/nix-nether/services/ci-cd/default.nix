{ pkgs, config, lib, ... }:

let
  env = path: builtins.readFile config.sops.secrets."${path}".path;
in
{
  # systemd.services.prepare-traefik = {
  #   description = "Prepare traefik settings";
  #   script = ''
  #     #!${pkgs.bash}/bin/bash
  #
  #     if [ ! -d "/traefik" ]; then
  #       mkdir -p "$FOLDER_PATH"
  #     fi
  #
  #   '';
  #   after = [ "docker.service" "docker.socket" ];
  #   wantedBy = [ "multi-user.target" ];
  # };
  #
  # virtualisation.oci-containers.containers = {
  #   traefik = {
  #     user = "root:root";
  #     image = "traefik:v3.1";
  #     autoStart = true;
  #
  #     ports = [
  #       "80:80"
  #       "443:443"
  #       "443:443/udp"
  #       "8080:8080"
  #     ];
  #     volumes = [
  #       "/var/run/docker.sock:/var/run/docker.sock"
  #     ];
  #     networks = [
  #       "host"
  #     ];
  #
  #     cmd = [
  #       "--ping=true"
  #       "--ping.entrypoint=http"
  #       "--api.dashboard=true"
  #       "--entrypoints.http.address=:80"
  #       "--entrypoints.https.address=:443"
  #       "--entrypoints.http.http.encodequerysemicolons=true"
  #       "--entryPoints.http.http2.maxConcurrentStreams=50"
  #       "--entrypoints.https.http.encodequerysemicolons=true"
  #       "--entryPoints.https.http2.maxConcurrentStreams=50"
  #       "--entrypoints.https.http3"
  #       "--providers.file.directory=/traefik/dynamic/"
  #       "--providers.docker.exposedbydefault=false"
  #       "--providers.file.watch=true"
  #       "--certificatesresolvers.letsencrypt.acme.httpchallenge=true"
  #       "--certificatesresolvers.letsencrypt.acme.httpchallenge.entrypoint=http"
  #       "--certificatesresolvers.letsencrypt.acme.storage=/traefik/acme.json"
  #       "--api.insecure=false"
  #       "--providers.docker=true"
  #       "--providers.file.directory=/traefik/dynamic"
  #
  #       # "--http.routers.gitlab.rule=Host(`gitlab.${env "ips/home-domain"}`)"
  #       # "--http.services.gitlab.loadbalancer.server.port=8080" 
  #       # "--entrypoints.http.forwardedHeaders.trustedIPs=0.0.0.0/0" 
  #       # "--http.routers.gitlab.rule=Host(`gitlab.example.com`)" 
  #       # "--http.services.gitlab.loadbalancer.server.port=8080" 
  #       # "--http.routers.gitlab.entrypoints=http,https"
  #     ];
  #   };
  # };

  # services.traefik = {
  #   enable = true;
  #   group = "docker";
  #   staticConfigOptions = {
  #     entryPoints = {
  #       web = {
  #         address = ":80";
  #       };
  #       websecure = {
  #         address = ":443";
  #       };
  #     };
  #     api = {
  #       dashboard = false;
  #     };
  #   };
  #   dynamicConfigOptions = {
  #     http = {
  #       routers = {
  #         gitlab = {
  #           rule = "Host(`gilab.booulder.xyz`)";
  #           service = "gitlab";
  #           entryPoints = [ "web" ];
  #         };
  #       };
  #     };
  #     services = {
  #       gitlab = {
  #         loadBalancer = {
  #           servers = [ { url = "http://localhost:8080"; } ];
  #         };
  #       };
  #     };
  #   };
  #
  # };

  services.gitlab = {
    enable = true;
    # host = "gitlab.${env "ips/home-domain"}";
    initialRootPasswordFile = "/run/secrets/gitlab/password";
    # port = 8080;
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
    virtualHosts = {
      localhost = {
        # locations."/".proxyPass = "http://localhost:8080";  # Прокси на порт GitLab
        locations."/".proxyPass = "http://unix:/run/gitlab/gitlab-workhorse.socket";
      };
    };
  };
  
}
