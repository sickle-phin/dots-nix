{
  config,
  inputs,
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
    monitor = osConfig.myOptions.monitors;

    windowrule = [
      "center 1, floating:1, xwayland:0"
      "opacity 0.97 0.97 1.0, class:Slack"
      "float, class:rpg_rt.exe|org.pulseaudio.pavucontrol|nm-connection-editor|xdg-desktop-portal-gtk"
      "size 40% 50%, class:org.pulseaudio.pavucontrol|nm-connection-editor"
      "size 50% 60%, class:xdg-desktop-portal-gtk"
      "pin, class:org.gnupg.pinentry-qt"
      "stayfocused, class:org.gnupg.pinentry-qt"
      "noshadow, floating:0"
      "animation popin, floating:1"
      "keepaspectratio, title:^(Picture-in-Picture|ピクチャーインピクチャー)$"
      "move 72% 7%,title:^(Picture-in-Picture|ピクチャーインピクチャー)$"
      "size 25%, title:^(Picture-in-Picture|ピクチャーインピクチャー)$"
      "float, title:^(Picture-in-Picture|ピクチャーインピクチャー)$"
      "pin, title:^(Picture-in-Picture|ピクチャーインピクチャー)$"
      "immediate, class:^steam.*"
    ];

    layerrule = [
      "noanim, ^(dms)$"
      "noscreenshare, ^(dms:notification-popup)$"
    ];

    workspace = mkIf (!osConfig.myOptions.isLaptop) [
      "1, monitor:HDMI-A-1, default:true"
      "2, monitor:DP-1, default:true"
    ];

    permission = [
      "${osConfig.programs.hyprland.portalPackage}/libexec/.xdg-desktop-portal-hyprland-wrapped, screencopy, allow"
      "${
        escapeRegex (
          getExe' inputs.dank-material-shell.packages.${pkgs.stdenv.hostPlatform.system}.dms-shell
            ".dms-wrapped"
        )
      }, screencopy, allow"
      "${getExe' config.programs.dank-material-shell.quickshell.package ".quickshell-wrapped"}, screencopy, allow"
      "${getExe pkgs.wl-screenrec}, screencopy, allow"
      "${pkgs.hyprlandPlugins.hypr-dynamic-cursors}/lib/libhypr-dynamic-cursors.so, plugin, allow"
      "${pkgs.hyprlandPlugins.hyprfocus}/lib/libhyprfocus.so, plugin, allow"
      ".*, plugin, deny"
    ]
    ++ optionals (osConfig.myOptions.kbPermission != null) [
      "${osConfig.myOptions.kbPermission}, keyboard, allow"
      ".*, keyboard, deny"
    ];
  };
}
