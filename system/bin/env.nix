{ pkgs, config, ... }:

let
  env = path: builtins.readFile config.sops.secrets."${path}".path;
in
{
  services.libinput.enable = true;
  services.acpid.enable = true;

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    fira-code
    fira-code-symbols
    liberation_ttf
    siji
    nerd-fonts.hack

  ];

  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    tor
    docker
    docker-compose
    bridge-utils
    libnotify
    xwaylandvideobridge
  ];

  environment.variables = {
    SOPS_AGE_KEY_FILE = "$HOME/Snowland/.keys";
  };

  services.monero = {
    enable = true;
    mining.enable = false;

    rpc = {
      user = "boulder";
      address = env "ips/home-local";
      port = 18081;
    };
  };
}
