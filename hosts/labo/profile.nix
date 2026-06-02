{
  myOptions = {
    enableGaming = false;
    gpu.vendor = "amd";
    hasBluetooth = false;
    isLaptop = false;
    kbLayout = "jp";
    maxFramerate = 60;
    monitors = [
      {
        output = "DP-1";
        mode = "3840x2160@60";
        position = "0x0";
        scale = 1.5;
        bitdepth = 10;
      }
      {
        output = "DP-2";
        mode = "1920x1080@60";
        position = "-1080x0";
        scale = 1;
        transform = 1;
      }
    ];
    monitorsLegacy = [
      "DP-1,3840x2160@60,0x0,1.5,vrr,2,bitdepth,10"
      "DP-2,1920x1080@60,-1080x0,1,transform,1,vrr,0"
      ", preferred, auto, 1"
    ];
    signingKey = "4FA80D9860EC2448";
    test.enable = false;
  };

  boot.loader.limine.extraEntries = ''
    /Windows
        protocol: efi
        path: boot():/EFI/Microsoft/Boot/bootmgfw.efi
  '';

  system.stateVersion = "26.05";
}
