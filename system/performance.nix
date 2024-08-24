{ config, lib, ... }:
with lib;
{
  powerManagement.cpuFreqGovernor = mkDefault "performance";

  services = mkIf config.myOptions.isLaptop {
    tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = mkDefault "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = mkDefault "powersave";

        CPU_ENERGY_PERF_POLICY_ON_AC = mkDefault "performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = mkDefault "balance_power";

        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 20;

        #Optional helps save long term battery health
        START_CHARGE_THRESH_BAT0 = 40; # 40 and bellow it starts to charge
        STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging
      };
    };
    thermald.enable = mkIf (config.myOptions.cpu == "intel") true;
  };
}
