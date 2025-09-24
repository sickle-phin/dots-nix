{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
let
  inherit (lib.modules) mkForce;
in
{
  imports = [ inputs.lanzaboote.nixosModules.lanzaboote ];
  boot = {
    enableContainers = false;

    lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
    };

    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = mkForce false;
        configurationLimit = 30;
        consoleMode = "max";
        editor = false;
      };
      grub = {
        enable = false;
        device = "nodev";
        efiSupport = true;
        useOSProber = false;
      };
      timeout = if config.myOptions.isLaptop then 0 else 30;
    };

    kernelPackages = pkgs.linuxPackages_xanmod_latest;

    consoleLogLevel = 0;

    initrd = {
      verbose = false;
      systemd.enable = true;
    };

    tmp.cleanOnBoot = true;

    plymouth = {
      enable = true;
      font = "${pkgs.mona-sans}/share/fonts/truetype/MonaSans-Regular.ttf";
      theme = "breeze";
      extraConfig = "DeviceScale=1";
    };

    kernelParams = [
      "quiet"
      "splash"
      "loglevel=3"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "rd.udev.log_level=3"
      "rd.systemd.show_status=auto"
      "fbcon=nodefer"
    ];
  };
}
