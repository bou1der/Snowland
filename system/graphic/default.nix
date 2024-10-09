

{ config, lib, pkgs, ... }:

{

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
	    intel-media-sdk
    ];
  };


}
