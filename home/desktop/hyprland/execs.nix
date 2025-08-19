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
    exec-once = [
      "hyprctl setcursor \"$(cat ${config.xdg.cacheHome}/theme/cursor_theme)\" \"$(cat ${config.xdg.cacheHome}/theme/hyprcursor_size)\""
      "uwsm app -- ${getExe pkgs.wayland-bongocat} -c ${config.xdg.configHome}/bongocat.conf"
      "uwsm app -- ${getExe pkgs.slack} --startup"
      "uwsm app -- ${getExe pkgs.wl-clip-persist} --clipboard regular"
      "QT_SCALE_FACTOR=1; uwsm app -- ${getExe pkgs.quickshell}"
      "mkdir -p ${config.home.homeDirectory}/Videos/Screencasts"
      "systemctl restart --user gamemoded.service"
    ]
    ++ optionals osConfig.myOptions.enableGaming [
      "steam -silent"
    ];

    exec-shutdown = [
      "${getExe pkgs.cliphist} wipe"
    ];
  };
}
