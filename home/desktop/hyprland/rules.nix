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
      "match:float true, match:xwayland false, center on"
      "match:float true, animation popin"
      "match:float false, no_shadow on"
      "match:class ^(nm-connection-editor)$, float on"
      "match:class ^(nm-connection-editor)$, size 40% 50%"
      "match:class ^(org.gnupg.pinentry-qt)$, pin on"
      "match:class ^(org.gnupg.pinentry-qt)$, stay_focused on"
      "match:class ^(org.quickshell)$, match:title ^(Authentication)$, pin on"
      "match:class ^(org.quickshell)$, match:title ^(Authentication)$, stay_focused on"
      "match:class ^(rpg_rt.exe)$, float on"
      "match:class ^(Slack)$, opacity 0.97 0.97 1.0"
      "match:class ^(xdg-desktop-portal-gtk)$, float on"
      "match:class ^(xdg-desktop-portal-gtk)$, size 50% 60%"
      "match:title ^(Picture-in-Picture|ピクチャーインピクチャー)$, float on"
      "match:title ^(Picture-in-Picture|ピクチャーインピクチャー)$, keep_aspect_ratio on"
      "match:title ^(Picture-in-Picture|ピクチャーインピクチャー)$, move 72% 7%"
      "match:title ^(Picture-in-Picture|ピクチャーインピクチャー)$, pin on"
      "match:title ^(Picture-in-Picture|ピクチャーインピクチャー)$, size 25%"
    ];

    layerrule = [
      "match:namespace ^(dms)$, no_anim on"
      "match:namespace ^(dms:notification-popup)$, no_screen_share on"
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
      # "${pkgs.hyprlandPlugins.hypr-dynamic-cursors}/lib/libhypr-dynamic-cursors.so, plugin, allow"
      "${pkgs.hyprlandPlugins.hyprfocus}/lib/libhyprfocus.so, plugin, allow"
      ".*, plugin, deny"
    ]
    ++ optionals (osConfig.myOptions.kbPermission != null) [
      "${osConfig.myOptions.kbPermission}, keyboard, allow"
      ".*, keyboard, deny"
    ];
  };
}
