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
      "init-theme"
      "mkdir -p ${config.home.homeDirectory}/Videos/Screencasts"
      "uwsm app -- ${getExe pkgs.wl-clip-persist} --clipboard regular"
      "sleep 15 && dms ipc call profile setImage ${../icons/sickle-phin.png}"
      "systemctl start --user app-com.mitchellh.ghostty.service"
      "sleep 4 && uwsm app -- ${getExe pkgs.slack} --startup"
      "${getExe pkgs.easyeffects} --load-preset ${config.services.easyeffects.preset}"
    ]
    ++ optionals (osConfig.myOptions.enableGaming && !osConfig.myOptions.isLaptop) [
      "steam -silent"
    ];

    exec-shutdown = [
      "${getExe pkgs.cliphist} wipe"
    ];
  };
}
