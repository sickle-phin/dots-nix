{
  config,
  lib,
  pkgs,
  ...
}:
{
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "hyprctl setcursor \"$(cat ${config.xdg.cacheHome}/theme/cursor_theme)\" \"$(cat ${config.xdg.cacheHome}/theme/hyprcursor_size)\""
      "uwsm finalize"
      "uwsm app -- swww-daemon"
      "hyprpanel"
      "systemctl --user enable --now hyprpolkitagent.service"
      "uwsm app -- hyprsunset"
      "sleep 5 && uwsm app -- slack --startup"
      "uwsm app -- ${lib.getExe pkgs.wl-clip-persist} --clipboard regular"
      "sleep 8 && [ ! -e \"${config.xdg.cacheHome}/theme/border.conf\" ] && notify-send -u critical -i ${../icons/hyprland.png} \"Hyprland\" \"Press mod+T to select theme\!\!\""
    ];

    exec-shutdown = [
      "${lib.getExe pkgs.cliphist} wipe"
    ];
  };
}
