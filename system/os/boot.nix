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
    lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };

    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = mkForce false;
        configurationLimit = 5;
        consoleMode = "max";
        editor = false;
      };
      grub = {
        enable = false;
        device = "nodev";
        efiSupport = true;
        useOSProber = false;
      };
      timeout = if config.myOptions.isLaptop then 5 else 30;
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
      theme = "breeze";
      extraConfig = "DeviceScale=1";
    };
  };
}
