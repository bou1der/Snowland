{ pkgs, lib, config, ... }:

let
    configFile = pkgs.writeTextDir "config/sunshine.conf"
    ''
      origin_web_ui_allowed=lan
    '';
in
{
  programs.steam.enable = true;

  environment.systemPackages = with pkgs; [
      sunshine
      xorg.xrandr
  ];

  security.rtkit.enable = true;

  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
        if (action.id == "org.freedesktop.login1.suspend" ||
            action.id == "org.freedesktop.login1.suspend-multiple-sessions" ||
            action.id == "org.freedesktop.login1.hibernate" ||
            action.id == "org.freedesktop.login1.hibernate-multiple-sessions")
        {
            return polkit.Result.NO;
        }
    });
  '';
  
  services.xserver = {
      enable = true;

      layout = "eu";
      videoDrivers = ["nvidia"];
      
      displayManager.gdm = {
        enable = true;
        autoSuspend = false;
      };

      desktopManager.gnome.enable = true;

      displayManager.autoLogin.enable = true;
      displayManager.autoLogin.user = "sunshine";
      displayManager.defaultSession = "gnome";

      monitorSection = ''
          VendorName     "Unknown"
          HorizSync   30-60
          VertRefresh 30-60

          ModelName      "Unknown"
          Option         "DPMS"
      '';

      deviceSection = ''
          VendorName "NVIDIA Corporation"
          Option      "AllowEmptyInitialConfiguration"
          Option      "ConnectedMonitor" "DFP"
          Option      "CustomEDID" "DFP-0"
      '';

      screenSection = ''
          DefaultDepth    24
          Option      "ModeValidation" "AllowNonEdidModes, NoVesaModes"
          Option      "MetaModes" "1920x1080"
          SubSection     "Display"
              Depth       24
          EndSubSection
      '';
  };

  # security.sudo.extraRules = [
  #   {  
  #     users = [ "sunshine" ];
  #     commands = [
  #       { 
  #         command = "ALL" ;
  #         options= [ "NOPASSWD" ];
  #       }
  #     ];
  #   }
  # ];

  security.wrappers.sunshine = {
      owner = "root";
      group = "root";
      capabilities = "cap_sys_admin+p";
      source = "${pkgs.sunshine}/bin/sunshine";
  };

  systemd.user.services.sunshine = {
      description = "Sunshine server";
      wantedBy = [ "graphical-session.target" ];
      startLimitIntervalSec = 500;
      startLimitBurst = 5;
      partOf = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];

      serviceConfig = {
          ExecStart = "${config.security.wrapperDir}/sunshine ${configFile}/config/sunshine.conf";
          Restart = "on-failure";
          RestartSec = "5s";
      };
  };
  
  # Avahi is used by Sunshine
  services.avahi.publish.userServices = true;

  # Required to simulate input
  boot.kernelModules = [ "uinput" ];

  # Maybe not necessary ? udev rules are ignored with ssh ?
  services.udev.extraRules = ''
    KERNEL=="uinput", GROUP="input", MODE="0660", OPTIONS+="static_node=uinput"
  '';

  # Force stop udisks2 (conflict with Gnome)
  services.udisks2.enable = lib.mkForce false;



  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    modesetting.enable = true;

    powerManagement.enable = false;
    powerManagement.finegrained = false;

    open = false;

    nvidiaSettings = true;
  };
    
}
