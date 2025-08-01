{ inputs, osConfig, ... }:
{
  xdg.configFile = {
    "uwsm/env".text = ''
      export WALLPAPER_DIR=${inputs.wallpaper}/wallpaper
      export ICON_DIR=${../icons}
      export NIXOS_OZONE_WL=1
      export XMODIFIERS=@im=fcitx
      export QT_IM_MODULE=fcitx
      export QT_QPA_PLATFORM="wayland;xcb"
      export QT_QPA_PLATFORMTHEME="kvantum"
      export QT_SCALE_FACTOR=1.2
      export QT_AUTO_SCREEN_SCALE_FACTOR=1
      export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
      export QS_ICON_THEME=Papirus-Dark
      export GDK_BACKEND=wayland,x11
      export MOZ_ENABLE_WAYLAND=1
      export MOZ_DISABLE_RDD_SANDBOX=1
      export SDL_VIDEODRIVER=wayland,x11
      export CLUTTER_BACKEND=wayland
      export SWWW_TRANSITION=center
      export SWWW_TRANSITION_FPS=${toString osConfig.myOptions.maxFramerate}
      export SWWW_TRANSITION_STEP=255
      export XCURSOR_THEME=catppuccin-mocha-dark-cursors
      export XCURSOR_SIZE=32
      export DXVK_HDR=1
      export ENABLE_HDR_WSI=1
      export GRIMBLAST_HIDE_CURSOR=0
      export PROTON_ENABLE_WAYLAND=0
      export PROTON_ENABLE_HDR=1
    '';

    "uwsm/env-hyprland".text = ''
      export HYPRCURSOR_THEME=catppuccin-mocha-dark-cursors
      export HYPRCURSOR_SIZE=32
    '';
  };
}
