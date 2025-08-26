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
      themePackages = [
        (pkgs.kdePackages.breeze-plymouth.override {
          logoFile = config.boot.plymouth.logo;
          logoName = "nixos";
          osName = "NixOS";
          osVersion = config.system.nixos.release;
        })
      ];
      extraConfig = "DeviceScale=1";
    };
  };
}
