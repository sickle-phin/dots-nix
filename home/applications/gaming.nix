# For Minecraft on native wayland, go to Settings → Minecraft → Tweaks in PrismLauncher and enable "Use system installation of GLFW".
# For Minecraft with an NVIDIA GPU, set __GL_THREADED_OPTIMIZATION=0.
{
  lib,
  osConfig,
  ...
}:
let
  inherit (lib.modules) mkIf mkMerge;
in
{
  config = mkIf (osConfig.myOptions.enableGaming) {
    home = {
      packages = [
        # pkgs.prismlauncher
      ];

      sessionVariables = mkMerge [
        {
          PROTON_ENABLE_WAYLAND = 0;
          PROTON_ENABLE_HDR = 1;
          WAYLANDDRV_PRIMARY_MONITOR = if osConfig.myOptions.isLaptop then "eDP-1" else "DP-1";
        }
        (mkIf (osConfig.myOptions.gpu.vendor == "nvidia") {
          PROTON_ENABLE_NGX_UPDATER = 1;
          DXVK_NVAPI_DRS_NGX_DLSS_SR_OVERRIDE = "on";
          DXVK_NVAPI_DRS_NGX_DLSS_RR_OVERRIDE = "on";
          DXVK_NVAPI_DRS_NGX_DLSS_FG_OVERRIDE = "on";
          DXVK_NVAPI_DRS_NGX_DLSS_SR_OVERRIDE_RENDER_PRESET_SELECTION = "render_preset_latest";
          DXVK_NVAPI_DRS_NGX_DLSS_RR_OVERRIDE_RENDER_PRESET_SELECTION = "render_preset_latest";
        })
      ];
    };
  };
}
