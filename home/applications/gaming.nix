# For Minecraft on native wayland, go to Settings → Minecraft → Tweaks in PrismLauncher and enable "Use system installation of GLFW".
# For Minecraft with an NVIDIA GPU, set __GL_THREADED_OPTIMIZATION=0.
{
  lib,
  pkgs,
  osConfig,
  ...
}:
let
  inherit (lib.modules) mkIf;
in
{
  config = mkIf osConfig.myOptions.enableGaming {
    home.packages = [
      pkgs.prismlauncher
    ];
  };
}
