{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib.lists) optionals;
  inherit (lib.modules) mkIf mkMerge;

  gpu = config.myOptions.gpu;
in
{
  boot = {
    kernelParams = optionals (gpu == "nvidia") [ "nvidia.NVreg_UsePageAttributeTable=1" ];
    initrd.kernelModules =
      (optionals (gpu == "intel") [ "i915" ])
      ++ (optionals (gpu == "nvidia") [
        "nvidia"
        "nvidia_modeset"
        "nvidia_uvm"
        "nvidia_drm"
      ]);
  };

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = optionals (gpu == "intel") [
        pkgs.intel-media-driver
        pkgs.libvdpau-va-gl
      ];
    };
    amdgpu = mkIf (gpu == "amd") {
      initrd.enable = true;
    };
    nvidia = mkIf (gpu == "nvidia") {
      package = config.boot.kernelPackages.nvidiaPackages.production;
      modesetting.enable = true;
      powerManagement.enable = true;
      nvidiaSettings = true;
      open = false;
    };
  };

  services = {
    xserver.videoDrivers =
      (optionals (gpu == "amd") [ "amdgpu" ]) ++ (optionals (gpu == "nvidia") [ "nvidia" ]);
  };

  environment.sessionVariables = mkMerge [
    (mkIf (gpu == "intel") {
      LIBVA_DRIVER_NAME = "iHD";
    })
    (mkIf (gpu == "amd") {
      LIBVA_DRIVER_NAME = "radeonsi";
    })
    (mkIf (gpu == "nvidia") {
      LIBVA_DRIVER_NAME = "nvidia";
      GBM_BACKEND = "nvidia-drm";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      NVD_BACKEND = "direct";
      __GL_GSYNC_ALLOWED = 1;
      __GL_VRR_ALLOWED = 0;
      VKD3D_CONFIG = "dxr11,dxr";
      PROTON_ENABLE_NVAPI = 1;
      DXVK_ENABLE_NVAPI = 1;
      PROTON_ENABLE_NGX_UPDATER = 0;
      PROTON_HIDE_NVIDIA_GPU = 0;
    })
  ];
}
