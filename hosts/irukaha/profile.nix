{
  myOptions = {
    enableGaming = true;
    gpu.vendor = "nvidia";
    hasBluetooth = true;
    isLaptop = false;
    kbLayout = "us";
    maxFramerate = 180;
    monitors = [
      {
        output = "DP-1";
        mode = "2560x1440@180";
        position = "0x0";
        scale = 1;
        bitdepth = 10;
      }
      {
        output = "HDMI-A-1";
        mode = "1920x1080@60";
        position = "-1920x0";
        scale = 1;
      }
    ];
    monitorsLegacy = [
      "DP-1,2560x1440@180,0x0,1,vrr,2,bitdepth,10"
      "HDMI-A-1,1920x1080@60,-1920x0,1"
      ", preferred, auto, 1"
    ];
    signingKey = "55E8B479957914C5";
    test.enable = false;
  };

  boot.loader.limine.extraEntries = ''
    /Windows
        protocol: efi
        path: boot():/EFI/Microsoft/Boot/bootmgfw.efi
  '';

  preservation.enable = true;

  services = {
    btrfs.autoScrub = {
      enable = true;
      interval = "weekly";
      fileSystems = [ "/btr_pool" ];
    };

    usbguard = {
      enable = false;
      rules = "";
    };
  };

  system.stateVersion = "26.05";
}
