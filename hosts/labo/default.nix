{
  imports = [
    ../../system
    ./hardware-configuration.nix
  ];

  myOptions = {
    cpu = "intel";
    enableGaming = false;
    gpu = "amd";
    hasBluetooth = false;
    isLaptop = false;
    kbLayout = "jp";
    maxFramerate = 60;
    monitor = [
      "HDMI-A-1,3840x2160@60,0x0,1.5,bitdepth,10,vrr,1"
      ", preferred, auto, 1"
    ];
    signingKey = "4FA80D9860EC2448";
  };

  time.hardwareClockInLocalTime = true;
  services.fstrim.enable = true;

  system.stateVersion = "24.05";
}
