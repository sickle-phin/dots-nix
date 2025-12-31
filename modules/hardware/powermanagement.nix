{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib.modules) mkDefault;
in
{
  powerManagement.cpuFreqGovernor = mkDefault "powersave";

  services = {
    power-profiles-daemon.enable = true;
    thermald.enable = config.hardware.cpu.intel.updateMicrocode;
    scx = {
      enable = true;
      package = pkgs.scx.rustscheds;
      scheduler = "scx_lavd";
    };
  };
}
