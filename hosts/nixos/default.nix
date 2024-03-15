# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
{
  imports =
    [
      ../../modules/system.nix
      #../../modules/i3.nix

      # Include the results of the hardware scan.
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
    kernelPackages = pkgs.linuxPackages_zen;
  };

  networking = {
    hostName = "nixos"; # Define your hostname.
    networkmanager.enable = true;
    nameservers = [ "8.8.8.8" "8.8.4.4" ];
    resolvconf.dnsExtensionMechanism = false;
  };

  # hardware.opengl = {
  #     enable = true;
  #     driSupport = true;
  # };

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

