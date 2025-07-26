{
  imports = [
    ../../system
    ./hardware-configuration.nix
  ];

  myOptions = {
    enableGaming = false;
    gpu.vendor = "amd";
    hasBluetooth = false;
    isLaptop = false;
    kbLayout = "jp";
    maxFramerate = 60;
    monitor = [
      "DP-1,3840x2160@60,0x0,1.5,vrr,1,bitdepth,10"
      "HDMI-A-1,1920x1080@60,-1080x0,1,transform,1,vrr,0"
      ", preferred, auto, 1"
    ];
    signingKey = "4FA80D9860EC2448";
  };

  time.hardwareClockInLocalTime = true;

  services = {
    usbguard = {
      enable = true;
      rules = ''
        allow id 056e:00e4 serial "" name "ELECOM BlueLED Mouse" hash "RIglSjpBvzvt6hj8DgwXrivAD4mu/tw/iXnpVuUFYPc=" parent-hash "jEP/6WzviqdJ5VSeTUY8PatCNBKeaREvo2OqdplND/o=" with-interface { 03:01:02 03:00:00 03:00:00 } with-connect-type "hotplug"
        allow id 174c:2074 serial "" name "ASM107x" hash "YTn13nEqBf/5/WIma/Qv+qGbdHqvXRdsLR1lCgHDdXQ=" parent-hash "jEP/6WzviqdJ5VSeTUY8PatCNBKeaREvo2OqdplND/o=" with-interface { 09:00:01 09:00:02 } with-connect-type "hardwired"
        allow id 174c:3074 serial "" name "ASM107x" hash "/IkXwFmioUm1EGuQOP70FeVlV7j930SIZqSijMjn1Tk=" parent-hash "prM+Jby/bFHCn2lNjQdAMbgc6tse3xVx+hZwjOPHSdQ=" via-port "2-4" with-interface 09:00:00 with-connect-type "hardwired"
        allow id 1c4f:0027 serial "" name "USB Keyboard" hash "gzB3pSPYLpoEhKQLsEli7se1ynHnm05rUm+V9bnsOlY=" parent-hash "jEP/6WzviqdJ5VSeTUY8PatCNBKeaREvo2OqdplND/o=" with-interface { 03:01:01 03:00:00 } with-connect-type "hotplug"
        allow id 26ce:01a2 serial "A02019100900" name "LED Controller" hash "WdEIqOrWT1p6UWeWoigz6TB5lGjHJbCt5NwfiEgXKw0=" parent-hash "jEP/6WzviqdJ5VSeTUY8PatCNBKeaREvo2OqdplND/o=" with-interface 03:00:00 with-connect-type "hardwired"
      '';
    };
  };

  system.stateVersion = "25.05"; # Do not edit
}
