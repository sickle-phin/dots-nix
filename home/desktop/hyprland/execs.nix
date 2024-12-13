{
  config,
  lib,
  pkgs,
  ...
}:
{
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "hyprctl setcursor \"$(cat ${config.xdg.cacheHome}/theme/cursor_theme)\" \"$(cat ${config.xdg.cacheHome}/theme/cursor_size)\""
      "uwsm finalize"
      "uwsm-app -- swww-daemon"
      # "ags"
      "uwsm-app -- waybar"
      "sleep 1 && pidof waybar || notify-send -u critical -i ${../icons/hyprland.png} \"Hyprland\" \"Press mod+T to select theme\!\!\""
      "uwsm-app -- hyprsunset"
      "uwsm-app -- slack --startup"
      "uwsm-app -- ${lib.getExe pkgs.wl-clip-persist} --clipboard regular"
    ];

    exec-shutdown = [
      "${lib.getExe pkgs.cliphist} wipe"
    ];
  };
}
