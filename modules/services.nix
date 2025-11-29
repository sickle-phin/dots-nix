{ config, lib, ... }:
let
  inherit (lib.modules) mkIf;
in
{
  services = {
    accounts-daemon.enable = true;
    dbus.implementation = "broker";
    fstrim.enable = true;
    fwupd.enable = true;
    gvfs.enable = true;
    hardware.openrgb.enable = true;
    ollama = {
      enable = config.networking.hostName == "irukaha";
      acceleration =
        if (config.myOptions.gpu.vendor == "amd") then
          "rocm"
        else if (config.myOptions.gpu.vendor == "nvidia") then
          "cuda"
        else
          null;
      rocmOverrideGfx = mkIf (config.networking.hostName == "labo") "10.3.0";
      loadModels = [
        "gpt-oss:20b"
      ];
    };
    printing.enable = true;
    udisks2 = {
      enable = true;
      mountOnMedia = true;
    };
    upower.enable = true;
  };

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    priority = 100;
    memoryPercent = 50;
  };

  boot.kernel.sysctl = {
    "vm.swappiness" = 180;
    "vm.watermark_boost_factor" = 0;
    "vm.watermark_scale_factor" = 125;
    "vm.page-cluster" = 0;
  };
}
