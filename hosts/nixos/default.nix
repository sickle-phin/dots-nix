{ config, pkgs, ... }:
{
  imports =
    [
      ../../modules
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot = {
    loader = {
      efi = {
        canTouchEfiVariables = true;
        #efiSysMountPoint = "/boot/EFI"; # ← use the same mount point here.
      };
      grub = {
        enable = true;
        device = "nodev"; #  "nodev"
        efiSupport = true;
        useOSProber = false;
        #efiInstallAsRemovable = true; # in case canTouchEfiVariables doesn't work for your system
      };
    };
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
  };

  time.hardwareClockInLocalTime = true;

  networking = {
    hostName = "nixos"; # Define your hostname.
    networkmanager.enable = true;
    nameservers = [ "8.8.8.8" "8.8.4.4" ];
    resolvconf.dnsExtensionMechanism = false;
  };

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver
      libvdpau-va-gl
    ];
  };

  environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; }; # Force intel-media-driver
 
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  environment.systemPackages = with pkgs; [
    steam-run
  ];
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  system.stateVersion = "23.11";

}

