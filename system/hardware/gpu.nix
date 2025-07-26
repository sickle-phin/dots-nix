{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib.lists) optionals;
  inherit (lib.modules) mkIf mkMerge;

  vendor = config.myOptions.gpu.vendor;
  isLegacy = config.myOptions.gpu.isLegacy;
in
{
  boot = {
    kernelParams = optionals (vendor == "nvidia") [ "nvidia.NVreg_UsePageAttributeTable=1" ];
    initrd.kernelModules =
      (optionals (vendor == "intel") [ "i915" ])
      ++ (optionals (vendor == "nvidia") [
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
      extraPackages =
        optionals (vendor == "intel") [
          pkgs.intel-media-driver
          pkgs.libvdpau-va-gl
        ]
        ++ optionals (vendor == "intel" && !isLegacy) [
          pkgs.vpl-gpu-rt
        ];
    };
    amdgpu = mkIf (vendor == "amd") {
      initrd.enable = true;
    };
    nvidia = mkIf (vendor == "nvidia") {
      package = config.boot.kernelPackages.nvidiaPackages.production;
      modesetting.enable = true;
      powerManagement.enable = true;
      nvidiaSettings = true;
      open = false;
    };
  };

  services = {
    xserver.videoDrivers =
      (optionals (vendor == "amd") [ "amdgpu" ]) ++ (optionals (vendor == "nvidia") [ "nvidia" ]);
  };

  environment.sessionVariables = mkMerge [
    (mkIf (vendor == "intel") {
      LIBVA_DRIVER_NAME = "iHD";
      VDPAU_DRIVER = "va_gl";
    })
    (mkIf (vendor == "amd") {
      LIBVA_DRIVER_NAME = "radeonsi";
      VDPAU_DRIVER = "radeonsi";
    })
    (mkIf (vendor == "nvidia") {
      LIBVA_DRIVER_NAME = "nvidia";
      GBM_BACKEND = "nvidia-drm";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      NVD_BACKEND = "direct";
      __GL_GSYNC_ALLOWED = 1;
      __GL_VRR_ALLOWED = 0;
    })
  ];
}
