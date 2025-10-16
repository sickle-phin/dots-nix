{ config, lib, ... }:
let
  inherit (lib.modules) mkIf;
in
{
  services = {
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
    priority = 5;
    memoryPercent = 50;
  };
}
