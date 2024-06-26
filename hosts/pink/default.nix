{ pkgs, ... }:
{
  imports =
    [
      ../../modules
      ./hardware-configuration.nix
      ./disk-config.nix
      ./impermanence.nix
      ./performance.nix
    ];

  networking = {
    hostName = "pink";
    networkmanager.enable = true;
    nameservers = [ "8.8.8.8" "8.8.4.4" ];
    resolvconf.dnsExtensionMechanism = false;
  };

  hardware = {
    bluetooth.enable = true;
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        intel-media-driver
        libvdpau-va-gl
      ];
    };
  };

  services.blueman.enable = true;

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

  system.stateVersion = "24.05";
}

