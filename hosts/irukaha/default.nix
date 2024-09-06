{
  imports = [
    ../../system
    ./hardware-configuration.nix
  ];

  myOptions = {
    cpu = "amd";
    enableGaming = true;
    gpu = "nvidia";
    hasBluetooth = true;
    isLaptop = false;
    kbLayout = "us";
    maxFramerate = 180;
    monitor = [
      "DP-1,2560x1440@180,0x0,1,vrr,1"
      "HDMI-A-1,1920x1080@60,-1920x0,1"
      ", preferred, auto, 1"
    ];
    signingKey = "55E8B479957914C5";
  };

  time.hardwareClockInLocalTime = true;

  system.stateVersion = "24.05";
}
