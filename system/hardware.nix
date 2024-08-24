{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  hasBluetooth = config.myOptions.hasBluetooth;
  gpu = config.myOptions.gpu;
in
{
  boot.initrd.kernelModules = mkMerge [
    (mkIf (gpu == "intel") [ "i915" ])
    (mkIf (gpu == "amd") [ "amdgpu" ])
    (mkIf (gpu == "nvidia") [
      "nvidia"
      "nvidia_modeset"
      "nvidia_uvm"
      "nvidia_drm"
    ])
  ];
  hardware = {
    enableRedistributableFirmware = true;
    bluetooth = mkIf hasBluetooth {
      enable = true;
      powerOnBoot = false;
    };
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages =
        with pkgs;
        mkIf (gpu == "intel") [
          intel-media-driver
          libvdpau-va-gl
        ];
    };
    nvidia = mkIf (gpu == "nvidia") {
      package = config.boot.kernelPackages.nvidiaPackages.beta;
      modesetting.enable = true;
      powerManagement.enable = true;
      nvidiaSettings = true;
      open = false;
    };
  };

  services = {
    blueman.enable = mkIf hasBluetooth true;
    xserver.videoDrivers = mkMerge [
      (mkIf (gpu == "amd") [ "amdgpu" ])
      (mkIf (gpu == "nvidia") [ "nvidia" ])
    ];
  };

  environment.sessionVariables = mkMerge [
    (mkIf (gpu == "intel") { LIBVA_DRIVER_NAME = "iHD"; })
    (mkIf (gpu == "amd") {
      LIBVA_DRIVER_NAME = "radeonsi";
      VDPAU_DRIVER = "radeonsi";
    })
    (mkIf (gpu == "nvidia") {
      LIBVA_DRIVER_NAME = "nvidia";
      VDPAU_DRIVER = "nvidia";
      GBM_BACKEND = "nvidia-drm";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      NVD_BACKEND = "direct";
      __GL_GSYNC_ALLOWED = 1;
      __GL_VRR_ALLOWED = 0;
      VK_DRIVER_FILES = "/run/opengl-driver/share/vulkan/icd.d/nvidia_icd.x86_64.json";
      VKD3D_CONFIG = "dxr11,dxr";
      PROTON_ENABLE_NVAPI = 1;
      DXVK_ENABLE_NVAPI = 1;
      PROTON_ENABLE_NGX_UPDATER = 1;
      PROTON_HIDE_NVIDIA_GPU = 0;
    })
  ];
}
