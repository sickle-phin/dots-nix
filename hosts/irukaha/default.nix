{ config, pkgs, ... }:
{
  imports =
    [
      ../../modules
      ../../modules/game.nix
      ../../secrets
      ./hardware-configuration.nix
      ./disk-config.nix
      ./impermanence.nix
    ];

  powerManagement.cpuFreqGovernor = "performance";
  time.hardwareClockInLocalTime = true;

  networking = {
    hostName = "irukaha";
    networkmanager.enable = true;
    nameservers = [ "8.8.8.8" "8.8.4.4" ];
    resolvconf.dnsExtensionMechanism = false;
  };

  services.xserver.videoDrivers = ["nvidia"];
  hardware = {
    bluetooth.enable = true;
    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.beta;
      modesetting.enable = true;
      powerManagement.enable = true;
      nvidiaSettings = true;
      open = false;
    };
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  services.blueman.enable = true;

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "nvidia";
    VDPAU_DRIVER = "nvidia";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    NVD_BACKEND = "direct";
    __GL_GSYNC_ALLOWED = 1;
    __GL_VRR_ALLOWED = 1;
    VK_DRIVER_FILES="/run/opengl-driver/share/vulkan/icd.d/nvidia_icd.x86_64.json";
    VKD3D_CONFIG="dxr11,dxr";
    PROTON_ENABLE_NVAPI = 1;
    DXVK_ENABLE_NVAPI=1;
    PROTON_ENABLE_NGX_UPDATER = 1;
    PROTON_HIDE_NVIDIA_GPU = 0;
  };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  system.stateVersion = "24.05";
}

