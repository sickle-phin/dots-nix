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
          # 1にするとゲームをWayland nativeで実行できるが，Steam Overlayが壊れます🐬
          # If set to 1, the game can be run in Wayland native, but Steam Overlay will be broken.
          PROTON_ENABLE_WAYLAND = 0;
          PROTON_ENABLE_HDR = 1;
          PROTON_NO_WM_DECORATION = 1;
          PROTON_WAYLAND_MONITOR = if osConfig.myOptions.isLaptop then "eDP-1" else "DP-1";
          PROTON_DISCORD_BRIDGE = 1;
        }
        (mkIf (osConfig.myOptions.gpu.vendor == "nvidia") {
          PROTON_DLSS_UPGRADE = 1;
          DXVK_NVAPI_DRS_NGX_DLSS_SR_OVERRIDE = "on";
          DXVK_NVAPI_DRS_NGX_DLSS_RR_OVERRIDE = "on";
          DXVK_NVAPI_DRS_NGX_DLSS_FG_OVERRIDE = "on";
          DXVK_NVAPI_DRS_NGX_DLSS_SR_OVERRIDE_RENDER_PRESET_SELECTION = "render_preset_m";
          DXVK_NVAPI_DRS_NGX_DLSS_RR_OVERRIDE_RENDER_PRESET_SELECTION = "render_preset_m";
          DXVK_NVAPI_DRS_NGX_DLSS_FG_OVERRIDE_RENDER_PRESET_SELECTION = "render_preset_m";
        })
      ];
    };
  };
}
