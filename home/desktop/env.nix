{
  inputs,
  lib,
  osConfig,
  ...
}:
let
  inherit (lib.strings) optionalString;
in
{
  xdg.configFile = {
    "uwsm/env".text = ''
      export WALLPAPER_DIR=${inputs.wallpaper}/wallpaper

      export GDK_BACKEND=wayland,x11

      export QT_IM_MODULE=fcitx
      export QT_QPA_PLATFORM="wayland;xcb"
      export QT_SCALE_FACTOR=1.2
      export QT_AUTO_SCREEN_SCALE_FACTOR=1
      export QT_WAYLAND_DISABLE_WINDOWDECORATION=1

      export SDL_VIDEODRIVER=wayland,x11
      export CLUTTER_BACKEND=wayland
      export NIXOS_OZONE_WL=1
      export MOZ_ENABLE_WAYLAND=1
      ${optionalString (osConfig.myOptions.gpu.vendor == "nvidia") "export MOZ_DISABLE_RDD_SANDBOX=1"}

      export XCURSOR_THEME=catppuccin-mocha-dark-cursors
      export XCURSOR_SIZE=39
      export XMODIFIERS=@im=fcitx

      export GRIMBLAST_HIDE_CURSOR=0
      export QS_ICON_THEME=Papirus-Dark
      export SWWW_TRANSITION=center
      export SWWW_TRANSITION_FPS=${toString osConfig.myOptions.maxFramerate}
      export SWWW_TRANSITION_STEP=255

      export PROTON_ENABLE_WAYLAND=1
      export PROTON_ENABLE_HDR=1
      ${optionalString (!osConfig.myOptions.isLaptop) "export WAYLANDDRV_PRIMARY_MONITOR=DP-1"}
    '';

    "uwsm/env-hyprland".text = ''
      export HYPRCURSOR_THEME=catppuccin-mocha-dark-cursors
      export HYPRCURSOR_SIZE=32
    '';
  };
}
