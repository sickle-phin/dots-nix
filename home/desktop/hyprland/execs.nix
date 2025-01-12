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
        "[ -e \"${config.xdg.configHome}/hyprpanel/config.json\" ] hyprpanel"
        "systemctl --user enable --now hyprpolkitagent.service"
        "uwsm app -- ${getExe pkgs.hyprsunset}"
        "sleep 8 && uwsm app -- ${getExe pkgs.slack} --startup"
        "uwsm app -- ${getExe pkgs.wl-clip-persist} --clipboard regular"
        "sleep 0.1 && [ ! -e \"${config.xdg.configHome}/hyprpanel/config.json\" ] && set-theme \"Catppuccin Mocha\" && hyprpanel"
      ]
      ++ optionals osConfig.myOptions.enableGaming [
        "uwsm app -- steam -silent"
      ];

    exec-shutdown = [
      "${getExe pkgs.cliphist} wipe"
    ];
  };
}
