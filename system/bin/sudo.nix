{ pkgs, vars, ... }:

{
  security.polkit = {
    enable = true;
    extraConfig = ''
      polkit.addRule(function(action, subject) {
      if (
          (action.id == "org.freedesktop.login1.suspend" ||
          action.id == "org.freedesktop.login1.reboot" ||
          action.id == "org.freedesktop.login1.power-off") &&
          subject.isInGroup("wheel")
        ) {
          return polkit.Result.YES;
        }
    '';
  };
  # security.sudo = {
  #   enable = true;
  #   extraRules = [{
  #     users = [ vars.username ];
  #     commands = [
  #       {
  #         command = "${pkgs.systemd}/bin/systemctl suspend";
  #         options = [ "NOPASSWD" ];
  #       }
  #       {
  #         command = "${pkgs.systemd}/bin/reboot";
  #         options = [ "NOPASSWD" ];
  #       }
  #       {
  #         command = "${pkgs.systemd}/bin/poweroff";
  #         options = [ "NOPASSWD" ];
  #       }
  #     ];
  #     groups = [ "wheel" ];
  #   }];

  # extraConfig = with pkgs; ''
  #   Defaults:picloud secure_path="${lib.makeBinPath [
  #     systemd
  #   ]}:/nix/var/nix/profiles/default/bin:/run/current-system/sw/bin"
  # '';
  # };
}
