{
  lib,
  osConfig,
  pkgs,
  ...
}:
let
  inherit (lib.meta) getExe;
  inherit (lib.modules) mkIf;

  host = osConfig.networking.hostName;
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
    plugins = [ pkgs.hyprlandPlugins.hypr-dynamic-cursors ];
    settings = {
      input = {
        kb_layout = osConfig.myOptions.kbLayout;
        follow_mouse = 1;

        touchpad = {
          natural_scroll = "no";
          scroll_factor = 0.2;
        };

        sensitivity = 0;
        repeat_delay = 250;
        repeat_rate = 60;
      };

      dwindle = {
        force_split = 2;
      };

      gestures = {
        workspace_swipe = true;
        workspace_swipe_distance = 800;
      };

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        force_default_wallpaper = 0;
        enable_swallow = true;
        swallow_regex = "org.wezfurlong.wezterm";
        vrr = 1;
      };

      xwayland = {
        force_zero_scaling = true;
      };

      render = {
        explicit_sync = 1;
        explicit_sync_kms = 1;
        direct_scanout = true;
      };

      cursor = {
        min_refresh_rate = mkIf (host == "irukaha") 48;
        default_monitor = mkIf (host == "irukaha" || host == "labo") "DP-1";
      };

      ecosystem.enforce_permissions = true;

      permission = [
        "${osConfig.programs.hyprland.portalPackage}/libexec/.xdg-desktop-portal-hyprland-wrapped, screencopy, allow"
        "${getExe pkgs.grim}, screencopy, allow"
        "${getExe pkgs.hyprlock}, screencopy, allow"
        "${getExe pkgs.hyprpicker}, screencopy, allow"
        "${getExe pkgs.wl-screenrec}, screencopy, allow"
        "${pkgs.hyprlandPlugins.hypr-dynamic-cursors}/lib/libhypr-dynamic-cursors.so, plugin, allow"
      ];

      experimental = {
        xx_color_management_v4 = false;
      };

      "plugin:dynamic-cursors".mode = "stretch";
    };
  };
}
