{
  imports = [
    ../../system
    ./hardware-configuration.nix
  ];

  myOptions = {
    cpu = "intel";
    enableGaming = true;
    gpu = "intel";
    hasBluetooth = true;
    isLaptop = true;
    kbLayout = "us";
    maxFramerate = 60;
    monitor = [ ", preferred, auto, 1" ];
    signingKey = "734F552670C87A09";
  };

  powerManagement.cpuFreqGovernor = "schedutil";

  services = {
    tlp.settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "schedutil";
      CPU_SCALING_GOVERNOR_ON_BAT = "schedutil";
    };
  };

  system.stateVersion = "24.05";
}
