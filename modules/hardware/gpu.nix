{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib.modules) mkIf mkMerge;
  vendor = config.myOptions.gpu.vendor;
in
mkMerge [
  {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };
  }

  (mkIf (vendor == "intel") {
    boot.initrd.kernelModules = [ "i915" ];

    hardware.graphics.extraPackages = [
      pkgs.intel-media-driver
      pkgs.libvdpau-va-gl
      pkgs.vpl-gpu-rt
    ];

    environment.sessionVariables = {
      LIBVA_DRIVER_NAME = "iHD";
      VDPAU_DRIVER = "va_gl";
    };
  })

  (mkIf (vendor == "amd") {
    hardware.amdgpu.initrd.enable = true;

    services.xserver.videoDrivers = [ "amdgpu" ];

    environment.sessionVariables = {
      LIBVA_DRIVER_NAME = "radeonsi";
      VDPAU_DRIVER = "radeonsi";
      MESA_SHADER_CACHE_MAX_SIZE = "12G";
    };
  })

  (mkIf (vendor == "nvidia") {
    services.xserver.videoDrivers = [ "nvidia" ];

    hardware = {
      nvidia = {
        moduleParams.nvidia = {
          NVreg_UsePageAttributeTable = 1;
        };
        modesetting.enable = true;
        powerManagement.enable = true;
        nvidiaSettings = true;
        open = true;
      };
      nvidia-container-toolkit.enable = true;
    };

    environment.sessionVariables = {
      LIBVA_DRIVER_NAME = "nvidia";
      GBM_BACKEND = "nvidia-drm";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      NVD_BACKEND = "direct";
      __GL_GSYNC_ALLOWED = "1";
      __GL_VRR_ALLOWED = "0";
      __GL_SHADER_DISK_CACHE_SIZE = "12000000000";
    };
  })
]
