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
    on = [
      {
        _args = [
          "hyprland.start"
          (lib.generators.mkLuaInline ''
            function()
                hl.exec_cmd("init-theme")
                hl.exec_cmd("mkdir -p ${config.home.homeDirectory}/Videos/Screencasts")
                hl.exec_cmd("cp -n ${config.xdg.configHome}/DankMaterialShell/default-settings.json ${config.xdg.configHome}/DankMaterialShell/settings.json && chmod u+w ${config.xdg.configHome}/DankMaterialShell/settings.json")
                hl.exec_cmd("cp -n ${config.xdg.configHome}/DankMaterialShell/default-plugin_settings.json ${config.xdg.configHome}/DankMaterialShell/plugin_settings.json && chmod u+w ${config.xdg.configHome}/DankMaterialShell/plugin_settings.json")
                hl.exec_cmd("cp -n ${config.xdg.stateHome}/DankMaterialShell/default-session.json ${config.xdg.stateHome}/DankMaterialShell/session.json && chmod u+w ${config.xdg.stateHome}/DankMaterialShell/session.json")
                hl.exec_cmd("sleep 15 && dms ipc call profile setImage ${../icons/sickle-phin.png}")
                hl.exec_cmd("systemctl start --user app-com.mitchellh.ghostty.service")
                hl.exec_cmd("systemctl start --user dsearch.service")
                hl.exec_cmd("sleep 8 && uwsm app -- ${getExe pkgs.slack} --startup")
                hl.exec_cmd("sleep 3 && ${getExe pkgs.easyeffects} --load-preset \"${config.services.easyeffects.preset}\"")
            end'')
        ];
      }
    ]
    ++ optionals (osConfig.myOptions.enableGaming && !osConfig.myOptions.isLaptop) [
      {
        _args = [
          "hyprland.start"
          (lib.generators.mkLuaInline ''
            function()
                hl.exec_cmd("sleep 3 && ${getExe osConfig.programs.steam.package} -silent")
            end'')
        ];
      }
    ];
  };
}
