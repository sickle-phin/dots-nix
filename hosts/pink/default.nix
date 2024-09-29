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

    usbguard = {
      enable = true;
      rules = ''
        allow id 056e:00e4 serial "" name "ELECOM BlueLED Mouse" hash "RIglSjpBvzvt6hj8DgwXrivAD4mu/tw/iXnpVuUFYPc=" parent-hash "jEP/6WzviqdJ5VSeTUY8PatCNBKeaREvo2OqdplND/o=" with-interface { 03:01:02 03:00:00 03:00:00 } with-connect-type "hotplug"
        allow id 32e6:9005 serial "" name "icspring camera" hash "JdrLViFwlPDsgWKDo/NvdkgE5UTIDD5hnt3xsVVhRKs=" parent-hash "jEP/6WzviqdJ5VSeTUY8PatCNBKeaREvo2OqdplND/o=" with-interface { 0e:01:00 0e:02:00 0e:02:00 0e:02:00 0e:02:00 0e:02:00 0e:02:00 0e:02:00 } with-connect-type "not used"
        allow id 8087:0a2a serial "" name "" hash "AyPZWy2XK0931kB9A/owYfk5xHEqnpDsJfdeLSGIyuk=" parent-hash "jEP/6WzviqdJ5VSeTUY8PatCNBKeaREvo2OqdplND/o=" with-interface { e0:01:01 e0:01:01 e0:01:01 e0:01:01 e0:01:01 e0:01:01 e0:01:01 } with-connect-type "not used"
      '';
    };
  };

  system.stateVersion = "24.05"; # Do not edit
}
