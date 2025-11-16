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
      "sleep 4 && uwsm app -- ${getExe pkgs.slack} --startup"
      "uwsm app -- ${getExe pkgs.wl-clip-persist} --clipboard regular"
      "mkdir -p ${config.home.homeDirectory}/Videos/Screencasts"
      "systemctl start --user app-com.mitchellh.ghostty.service"
      "sleep 15 && dms ipc call profile setImage ${../icons/sickle-phin.png}"
    ]
    ++ optionals (osConfig.myOptions.enableGaming && !osConfig.myOptions.isLaptop) [
      "steam -silent"
    ];

    exec-shutdown = [
      "${getExe pkgs.cliphist} wipe"
    ];
  };
}
