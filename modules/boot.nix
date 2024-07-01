{ lib
, pkgs
, ...
}: {
  boot = {
    lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };

    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = lib.mkForce false;
        configurationLimit = 5;
        consoleMode = "max";
      };
      grub = {
        enable = false;
        device = "nodev";
        efiSupport = true;
        useOSProber = false;
      };
    };

    kernelPackages = pkgs.linuxPackages_xanmod_latest;

    consoleLogLevel = 0;

    initrd = {
      verbose = false;
      systemd = {
        enable = true;
        network.wait-online.enable = false;
      };
    };

    tmp.cleanOnBoot = true;

    plymouth = {
      enable = true;
      theme = "breeze";
      extraConfig = "DeviceScale=1";
    };
  };
}
