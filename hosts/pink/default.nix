{
  imports = [
    ../../system
    ../../system/game.nix
    ./hardware-configuration.nix
  ];

  myOptions = {
    cpu = "intel";
    gpu = "intel";
    hasBluetooth = true;
    isLaptop = true;
    kbLayout = "us";
    maxFramerate = 60;
    monitor = [ ", preferred, auto, 1" ];
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
