
{ config, lib, pkgs, ... }:

{

  services.tlp = {
    enable = true;
    settings = {
      TLP_ENABLE=1;

      DISK_DEVICES="nvme0n1 sda";

      AHCI_RUNTIME_PM_ON_AC="auto";
      AHCI_RUNTIME_PM_ON_BAT="auto";
      AHCI_RUNTIME_PM_TIMEOUT=10;

      SOUND_POWER_SAVE_ON_AC=1;
      SOUND_POWER_SAVE_ON_BAT=1;

      CPU_SCALING_GOVERNOR_ON_AC = "powersave";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_performance";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 20;

      MEM_SLEEP_ON_AC="deep";
      MEM_SLEEP_ON_BAT="deep";

      START_CHARGE_THRESH_BAT0 = 40; 
      STOP_CHARGE_THRESH_BAT0 = 90;     

      CPU_BOOST_ON_AC = 0;
      CPU_BOOST_ON_BAT = 0;
    };
  };
  systemd.sleep.extraConfig = ''
    HibernateDelaySec=30s
    SuspendState=mem
  '';

}
