{
  config,
  lib,
  osConfig,
  pkgs,
  ...
}:
let
  inherit (lib.lists) optionals;
  inherit (lib.meta) getExe;
in
{
  wayland.windowManager.hyprland.settings = {
    exec-once =
      [
        "hyprctl setcursor \"$(cat ${config.xdg.cacheHome}/theme/cursor_theme)\" \"$(cat ${config.xdg.cacheHome}/theme/hyprcursor_size)\""
        "uwsm finalize"
        "uwsm app -- swww-daemon"
        "hyprpanel"
        "systemctl --user enable --now hyprpolkitagent.service"
        "uwsm app -- ${getExe pkgs.hyprsunset}"
        "sleep 8 && uwsm app -- ${getExe pkgs.slack} --startup"
        "uwsm app -- ${getExe pkgs.wl-clip-persist} --clipboard regular"
        "sleep 8 && [ ! -e \"${config.xdg.cacheHome}/theme/border.conf\" ] && notify-send -u critical -i ${../icons/hyprland.png} \"Hyprland\" \"Press mod+T to select theme\!\!\""
      ]
      ++ optionals osConfig.myOptions.enableGaming [
        "sleep 8 && uwsm app -- ${getExe pkgs.steam} -silent"
      ];

    exec-shutdown = [
      "${getExe pkgs.cliphist} wipe"
    ];
  };
}
