{
  imports = [
    ../../system
    ../../system/game.nix
    ./hardware-configuration.nix
  ];

  myOptions = {
    cpu = "amd";
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
  };

  time.hardwareClockInLocalTime = true;

  system.stateVersion = "24.05";
}
