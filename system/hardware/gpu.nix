{
  config,
  lib,
  pkgs,
  ...
}:
let
  gpu = config.myOptions.gpu;
in
{
  boot = {
    kernelParams = [ "nvidia.NVreg_UsePageAttributeTable=1" ];
    initrd.kernelModules = lib.mkMerge [
      (lib.mkIf (gpu == "intel") [ "i915" ])
      (lib.mkIf (gpu == "amd") [ "amdgpu" ])
      (lib.mkIf (gpu == "nvidia") [
        "nvidia"
        "nvidia_modeset"
        "nvidia_uvm"
        "nvidia_drm"
      ])
    ];
  };

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = lib.mkIf (gpu == "intel") [
        pkgs.intel-media-driver
        pkgs.libvdpau-va-gl
      ];
    };
    nvidia = lib.mkIf (gpu == "nvidia") {
      package = config.boot.kernelPackages.nvidiaPackages.beta;
      modesetting.enable = true;
      powerManagement.enable = true;
      nvidiaSettings = true;
      open = false;
    };
  };

  services = {
    xserver.videoDrivers = lib.mkMerge [
      (lib.mkIf (gpu == "amd") [ "amdgpu" ])
      (lib.mkIf (gpu == "nvidia") [ "nvidia" ])
    ];
  };

  environment.sessionVariables = lib.mkMerge [
    (lib.mkIf (gpu == "intel") {
      LIBVA_DRIVER_NAME = "iHD";
    })
    (lib.mkIf (gpu == "amd") {
      LIBVA_DRIVER_NAME = "radeonsi";
    })
    (lib.mkIf (gpu == "nvidia") {
      LIBVA_DRIVER_NAME = "nvidia";
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
