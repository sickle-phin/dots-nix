{ osConfig, ... }:
{
  xdg.configFile = {
    "uwsm/env".text = ''
      export NIXOS_OZONE_WL=1
      export GDK_BACKEND=wayland,x11
      export QT_QPA_PLATFORM="wayland;xcb"
      export QT_SCALE_FACTOR=1.2
      export QT_AUTO_SCREEN_SCALE_FACTOR=1
      export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
      export MOZ_ENABLE_WAYLAND=1
      export SDL_VIDEODRIVER=wayland
      export CLUTTER_BACKEND=wayland
      export SWWW_TRANSITION=center
      export SWWW_TRANSITION_FPS=${toString osConfig.myOptions.maxFramerate}
      export SWWW_TRANSITION_STEP=255
    '';

    "uwsm/env-hyprland".text = ''
      export HYPRCURSOR_THEME=catppuccin-mocha-dark-cursors
      export HYPRCURSOR_SIZE=32
    '';
  };
}
