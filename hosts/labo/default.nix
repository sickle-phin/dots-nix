{ config, pkgs, lib, ... }:
{
  imports =
    [
      ../../modules
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot = {
    lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };
    loader = {
      efi = {
        canTouchEfiVariables = true;
      };
      systemd-boot = {
        enable = lib.mkForce false;
        consoleMode = "max";
      };
      grub = {
        enable = false;
        device = "nodev";
        efiSupport = true;
        useOSProber = false;
        #efiInstallAsRemovable = true; # in case canTouchEfiVariables doesn't work for your system
      };
    };
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
  };

  powerManagement.cpuFreqGovernor = "performance";
  time.hardwareClockInLocalTime = true;

  networking = {
    hostName = "labo";
    networkmanager.enable = true;
    nameservers = [ "8.8.8.8" "8.8.4.4" ];
    resolvconf.dnsExtensionMechanism = false;
  };

  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
  };

  services.xserver.videoDrivers = [ "amdgpu" ];

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "radeonsi";
  };

  #environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; }; # Force intel-media-driver
 
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  system.stateVersion = "23.11";

}

