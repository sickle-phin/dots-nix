{
  imports = [
    ../../system
    ./hardware-configuration.nix
  ];

  myOptions = {
    cpu = "intel";
    gpu = "amd";
    hasBluetooth = false;
    isLaptop = false;
    kbLayout = "jp";
    maxFramerate = 60;
    monitor = [
      "HDMI-A-1,3840x2160@60,0x0,1.5,bitdepth,10,vrr,1"
      ", preferred, auto, 1"
    ];
  };

  time.hardwareClockInLocalTime = true;

  system.stateVersion = "24.05";
}
