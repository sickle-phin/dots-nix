{ config, lib, ... }:
{
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";

  services = {
    power-profiles-daemon.enable = true;
    thermald.enable = lib.mkIf (config.myOptions.cpu == "intel") true;
  };
}
