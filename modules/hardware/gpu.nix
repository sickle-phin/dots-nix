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
    initrd.kernelModules = optionals (vendor == "intel") [ "i915" ];
  };

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages =
        optionals (vendor == "intel") [
          pkgs.intel-media-driver
          # pkgs.libvdpau-va-gl
        ]
        ++ optionals (vendor == "intel" && !isLegacy) [
          pkgs.vpl-gpu-rt
        ];
    };
    amdgpu = mkIf (vendor == "amd") {
      initrd.enable = true;
    };
    nvidia = mkIf (vendor == "nvidia") {
      package = config.boot.kernelPackages.nvidiaPackages.beta;
      modesetting.enable = true;
      powerManagement.enable = true;
      nvidiaSettings = true;
      open = false;
    };
    nvidia-container-toolkit.enable = vendor == "nvidia";
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
      PROTON_ENABLE_NGX_UPDATER = 1;
      DXVK_NVAPI_DRS_NGX_DLSS_SR_OVERRIDE = "on";
      DXVK_NVAPI_DRS_NGX_DLSS_RR_OVERRIDE = "on";
      DXVK_NVAPI_DRS_NGX_DLSS_FG_OVERRIDE = "on";
      DXVK_NVAPI_DRS_NGX_DLSS_SR_OVERRIDE_RENDER_PRESET_SELECTION = "render_preset_latest";
      DXVK_NVAPI_DRS_NGX_DLSS_RR_OVERRIDE_RENDER_PRESET_SELECTION = "render_preset_latest";
    })
  ];
}
