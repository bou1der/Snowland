

{ config, lib, pkgs, ... }:

{

  environment = {
    variables = {
      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_TYPE = "wayland";
      XDG_SESSION_DESKTOP = "Hyprland";
    };

    systemPackages = with pkgs; [
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
  };




  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
  };

  # services.pgadmin = {
  #   enable = true;
  #   port = 5050;
  #   initialEmail = "admin@mail.ru";
  #   initialPasswordFile = ./pass;
  # };


  

}
