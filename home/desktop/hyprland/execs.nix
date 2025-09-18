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
      "set-theme"
      "uwsm app -- ${getExe pkgs.wayland-bongocat} -c ${config.xdg.configHome}/bongocat.conf"
      "uwsm app -- ${getExe pkgs.slack} --startup"
      "uwsm app -- ${getExe pkgs.wl-clip-persist} --clipboard regular"
      "QT_SCALE_FACTOR=1; uwsm app -- ${getExe pkgs.quickshell}"
      "mkdir -p ${config.home.homeDirectory}/Videos/Screencasts"
      "systemctl start --user app-com.mitchellh.ghostty.service"
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
