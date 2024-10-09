
{ pkgs, ... }:

{
  # systemd.user.services = {
  #   battery-watcher = {
  #     Install = {
  #       WantedBy = [ "timers.target" ];
  #     };
  #     Service = {
  #       ExecStart = "${../../scripts/check-battery.sh}";
  #
  #     };
  #
  #   };
  # };
  # systemd.user.timers."battery-timer" = {
  #   timerConfig = {
  #     OnBootSec = "5s";
  #     OnUnitActiveSec = "5s";
  #     Unit = "battary-watcher.service";
  #   };
  # };
  # services = {
  #   acpid = {
  #     enable = true;
  #   };
  # };
}
