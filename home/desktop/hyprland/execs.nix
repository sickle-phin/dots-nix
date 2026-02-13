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
      "cp -n ${config.xdg.configHome}/DankMaterialShell/default-settings.json ${config.xdg.configHome}/DankMaterialShell/settings.json && chmod u+w ${config.xdg.configHome}/DankMaterialShell/settings.json"
      "cp -n ${config.xdg.stateHome}/DankMaterialShell/default-session.json ${config.xdg.stateHome}/DankMaterialShell/session.json && chmod u+w ${config.xdg.stateHome}/DankMaterialShell/session.json"
      "sleep 15 && dms ipc call profile setImage ${../icons/sickle-phin.png}"
      "systemctl start --user app-com.mitchellh.ghostty.service"
      "systemctl start --user dsearch.service"
      "sleep 7 && uwsm app -- ${getExe pkgs.slack} --startup"
      "sleep 3 && ${getExe pkgs.easyeffects} --load-preset ${config.services.easyeffects.preset}"
    ]
    ++ optionals (osConfig.myOptions.enableGaming && !osConfig.myOptions.isLaptop) [
      "steam -silent"
    ];

    exec-shutdown = [
      "${getExe pkgs.cliphist} wipe"
    ];
  };
}
