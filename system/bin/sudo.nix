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
}
