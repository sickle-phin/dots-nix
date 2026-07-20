{
  config,
  lib,
  osConfig,
  pkgs,
  ...
}:
let
  inherit (lib.lists) optionals;
  inherit (lib.meta) getExe getExe';
  inherit (lib.modules) mkIf;
  inherit (lib.strings) escapeRegex;
in
{
  wayland.windowManager.hyprland.settings = {
    monitor = osConfig.myOptions.monitors ++ [
      {
        output = "";
        mode = "preferred";
        position = "auto";
        scale = 1;
      }
    ];

    window_rule = [
      {
        match = {
          float = true;
          xwayland = false;
        };
        center = true;
      }
      {
        match.float = true;
        animation = "popin";
      }
      {
        match.float = false;
        no_shadow = true;
      }
      {
        match.class = "^(nm-connection-editor)$";
        float = true;
        size = [
          "(monitor_w*0.45)"
          "(monitor_h*0.45)"
        ];
      }
      {
        match.class = "^(org.gnupg.pinentry-qt)$";
        pin = true;
        stay_focused = true;
      }
      {
        match = {
          class = "^(com.danklinux.dms)$";
          title = "^(Authentication)$";
        };
        pin = true;
        stay_focused = true;
      }
      {
        match.class = "^(rpg_rt.exe)$";
        float = true;
      }
      {
        match.class = "^(Slack)$";
        opacity = "0.97 0.97 1.0";
      }
      {
        match.class = "^(xdg-desktop-portal-gtk)$";
        float = true;
        size = [
          "(monitor_w*0.5)"
          "(monitor_h*0.6)"
        ];
      }
      {
        match.title = "^(Picture-in-Picture|ピクチャーインピクチャー)$";
        float = true;
        keep_aspect_ratio = true;
        move = [
          "(monitor_w*0.73)"
          "(monitor_h*0.72)"
        ];
        pin = true;
        size = [
          "(monitor_w*0.25)"
          "(monitor_h*0.25)"
        ];
      }
    ];

    layer_rule = [
      {
        match.namespace = "^(dms)$";
        no_anim = true;
      }
      {
        match.namespace = "^(dms:notification-popup)$";
        no_screen_share = true;
      }
    ];

    workspace_rule =
      let
        subMonitor = if (osConfig.networking.hostName == "irukaha") then "HDMI-A-1" else "DP-2";
      in
      mkIf (!osConfig.myOptions.isLaptop) [
        {
          workspace = 1;
          monitor = subMonitor;
          default = true;
        }
        {
          workspace = 2;
          monitor = "DP-1";
          default = true;
        }
      ];

    permission = [
      {
        binary = "${osConfig.programs.hyprland.portalPackage}/libexec/.xdg-desktop-portal-hyprland-wrapped";
        type = "screencopy";
        mode = "allow";
      }
      {
        binary = "${escapeRegex (getExe config.programs.dank-material-shell.package)}";
        type = "screencopy";
        mode = "allow";
      }
      {
        binary = "${getExe' config.programs.dank-material-shell.quickshell.package ".quickshell-wrapped"}";
        type = "screencopy";
        mode = "allow";
      }
      {
        binary = "${getExe pkgs.wl-screenrec}";
        type = "screencopy";
        mode = "allow";
      }
      {
        binary = "${pkgs.hyprlandPlugins.hypr-dynamic-cursors}/lib/libhypr-dynamic-cursors.so";
        type = "plugin";
        mode = "allow";
      }
      {
        binary = "${pkgs.hyprlandPlugins.hyprfocus}/lib/libhyprfocus.so";
        type = "plugin";
        mode = "allow";
      }
      {
        binary = ".*";
        type = "plugin";
        mode = "deny";
      }
    ]
    ++ optionals (osConfig.myOptions.kbPermission != null) [
      {
        binary = "${osConfig.myOptions.kbPermission}";
        type = "keyboard";
        mode = "allow";
      }
      {
        binary = ".*";
        type = "keyboard";
        mode = "deny";
      }
    ];
  };
}
