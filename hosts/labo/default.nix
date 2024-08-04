{
  imports =
    [
      ../../system
      ../../secrets
      ./hardware-configuration.nix
    ];

  powerManagement.cpuFreqGovernor = "performance";
  time.hardwareClockInLocalTime = true;

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  services.xserver.videoDrivers = [ "amdgpu" ];

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "radeonsi";
    VDPAU_DRIVER = "radeonsi";
  };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  system.stateVersion = "24.05";
}

