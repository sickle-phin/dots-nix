{ config, lib, ... }:
let
  inherit (lib.modules) mkDefault;
  inherit (lib.modules) mkIf;
in
{
  powerManagement.cpuFreqGovernor = mkDefault "powersave";

  services = {
    power-profiles-daemon.enable = true;
    thermald.enable = mkIf (config.myOptions.cpu == "intel") true;
  };
}
