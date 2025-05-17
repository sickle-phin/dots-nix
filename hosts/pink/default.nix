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
    impermanence.enable = true;
    isLaptop = true;
    kbLayout = "us";
    maxFramerate = 60;
    monitor = [ ", preferred, auto, 1" ];
    signingKey = "734F552670C87A09";
    ssh.publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMA+5fm6IM/J41+gVi99cXZ3VzVo1cwapCUVanQUGCyw 114330858+sickle-phin@users.noreply.github.com";
  };

  powerManagement.cpuFreqGovernor = "schedutil";

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
        allow id 32e6:9005 serial "" name "icspring camera" hash "JdrLViFwlPDsgWKDo/NvdkgE5UTIDD5hnt3xsVVhRKs=" parent-hash "jEP/6WzviqdJ5VSeTUY8PatCNBKeaREvo2OqdplND/o=" with-interface { 0e:01:00 0e:02:00 0e:02:00 0e:02:00 0e:02:00 0e:02:00 0e:02:00 0e:02:00 } with-connect-type "not used"
        allow id 8087:0a2a serial "" name "" hash "AyPZWy2XK0931kB9A/owYfk5xHEqnpDsJfdeLSGIyuk=" parent-hash "jEP/6WzviqdJ5VSeTUY8PatCNBKeaREvo2OqdplND/o=" with-interface { e0:01:01 e0:01:01 e0:01:01 e0:01:01 e0:01:01 e0:01:01 e0:01:01 } with-connect-type "not used"
        allow id 057e:2009 serial "000000000001" name "Pro Controller" hash "+157t1YB+XgpiViQkQNzRvNV8ZJcI0LWaB6GYpHRjhQ=" parent-hash "jEP/6WzviqdJ5VSeTUY8PatCNBKeaREvo2OqdplND/o=" with-interface 03:00:00 with-connect-type "hotplug"
        allow id 0b95:1790 serial "003F1DB6" name "AX88179A" with-connect-type "hotplug"
      '';
    };
  };

  system.stateVersion = "24.11"; # Do not edit
}
