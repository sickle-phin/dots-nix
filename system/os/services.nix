{
  services = {
    fstrim.enable = true;
    fwupd.enable = true;
    gvfs.enable = true;
    hardware.openrgb.enable = true;
    printing.enable = true;
    udisks2 = {
      enable = true;
      mountOnMedia = true;
    };
    upower.enable = true;
  };

  zramSwap = {
    enable = false;
    algorithm = "zstd";
    priority = 5;
    memoryPercent = 50;
  };
}
