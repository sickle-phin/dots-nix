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
    impermanence.enable = true;
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

  services = {
    btrfs.autoScrub = {
      enable = true;
      interval = "weekly";
      fileSystems = [ "/btr_pool" ];
    };

    usbguard = {
      enable = true;
      rules = ''
        allow id 056e:00e4 serial "" name "ELECOM BlueLED Mouse" hash "RIglSjpBvzvt6hj8DgwXrivAD4mu/tw/iXnpVuUFYPc=" parent-hash "jEP/6WzviqdJ5VSeTUY8PatCNBKeaREvo2OqdplND/o=" with-interface { 03:01:02 03:00:00 03:00:00 } with-connect-type "hotplug"
        allow id 3554:fa09 serial "" name "2.4G Wireless Receiver" hash "qrdhK54TwFaT/u6ozq2EsmXzLxu3sWNfFWtzuUdswpY=" parent-hash "+XquLJ1PcxL46fLrSbVNwpIn3oJQYx8VHJUWeqlOsws=" with-interface { 03:01:01 03:01:02 } with-connect-type "hotplug"
        allow id 258a:010c serial "" name "Gaming Keyboard" hash "yIvq5btwk5v+JnBoa7s461MLETTMj0XpswdBh2bTTvY=" parent-hash "+XquLJ1PcxL46fLrSbVNwpIn3oJQYx8VHJUWeqlOsws=" with-interface { 03:01:01 03:00:00 } with-connect-type "hotplug"
        allow id 1ea7:0066 serial "" name "2.4G Mouse" hash "YjVmEGYRcwJqbI/ndHVSSGE84WM6ppRrsXsRMRvZeQQ=" parent-hash "+XquLJ1PcxL46fLrSbVNwpIn3oJQYx8VHJUWeqlOsws=" with-interface { 03:01:01 03:01:02 } with-connect-type "hotplug"
        allow id 05e3:0610 serial "" name "USB2.0 Hub" hash "p0xurg8ayXbgrHAmFBL5BElzY8M/rvDA/w3li6d/wtw=" parent-hash "+XquLJ1PcxL46fLrSbVNwpIn3oJQYx8VHJUWeqlOsws=" with-interface { 09:00:01 09:00:02 } with-connect-type "hotplug"
        allow id 0e8d:0608 serial "000000000" name "Wireless_Device" hash "lcL25SKcS6sKWfdRl/KurZZ/6q9takvgKyf+UFpaWBk=" parent-hash "+XquLJ1PcxL46fLrSbVNwpIn3oJQYx8VHJUWeqlOsws=" with-interface { e0:01:01 e0:01:01 e0:01:01 e0:01:01 e0:01:01 e0:01:01 e0:01:01 e0:01:01 e0:01:01 e0:01:01 } with-connect-type "hotplug"
        allow id 26ce:01a2 serial "A02019100900" name "LED Controller" hash "WdEIqOrWT1p6UWeWoigz6TB5lGjHJbCt5NwfiEgXKw0=" parent-hash "+Lsm3uXJrL0KwWr8E3Phv/ov65s/QLIBmiqongfUTzc=" with-interface 03:00:00 with-connect-type "hotplug"
        allow id 057e:2009 serial "000000000001" name "Pro Controller" hash "+157t1YB+XgpiViQkQNzRvNV8ZJcI0LWaB6GYpHRjhQ=" with-interface 03:00:00 with-connect-type "hotplug"
        allow id 03f0:0491 serial "4111" name "HyperX QuadCast" hash "AE4JhWCHncb7sSfr35TwSttQhr9L6LxSTPMZnYhamjE=" parent-hash "+XquLJ1PcxL46fLrSbVNwpIn3oJQYx8VHJUWeqlOsws=" with-interface { 01:01:00 01:02:00 01:02:00 01:02:00 01:02:00 03:00:00 } with-connect-type "hotplug"
      '';

    };
  };

  system.stateVersion = "24.11"; # Do not edit
}
