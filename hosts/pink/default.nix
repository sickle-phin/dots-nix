{ pkgs
, ...
}: {
  imports =
    [
      ../../system
      ../../system/game.nix
      ../../secrets
      ./hardware-configuration.nix
      ./disk-config.nix
      ./impermanence.nix
      ./performance.nix
    ];

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

  environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; };
 
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  system.stateVersion = "24.05";
}

