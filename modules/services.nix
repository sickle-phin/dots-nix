{ config, ... }:
{
  services = {
    fstrim.enable = true;
    fwupd.enable = true;
    gvfs.enable = true;
    hardware.openrgb.enable = true;
    ollama = {
      enable = !config.myOptions.isLaptop;
      acceleration =
        if (config.myOptions.gpu.vendor == "amd") then
          "rocm"
        else if (config.myOptions.gpu.vendor == "nvidia") then
          "cuda"
        else
          null;
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
