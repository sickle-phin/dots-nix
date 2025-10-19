{
  lib,
  osConfig,
  pkgs,
  ...
}:
let
  inherit (lib.lists) optionals;
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
        kb_options = "ctrl:nocaps";
        follow_mouse = 1;

        touchpad = {
          natural_scroll = false;
          scroll_factor = 0.2;
          drag_lock = 0;
        };

        sensitivity = 0;
        repeat_delay = 250;
        repeat_rate = 60;
      };

      gestures.workspace_swipe_distance = 1000;

      dwindle = {
        force_split = 2;
      };

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        force_default_wallpaper = 0;
        enable_swallow = true;
        swallow_regex = "com.mitchellh.ghostty";
        vrr = 1;
      };

      xwayland = {
        force_zero_scaling = true;
      };

      render = {
        direct_scanout = 2;
        new_render_scheduling = true;
      };

      cursor = {
        min_refresh_rate = mkIf (host == "irukaha") 48;
        default_monitor = mkIf (!osConfig.myOptions.isLaptop) "DP-1";
      };

      ecosystem = {
        no_update_news = true;
        no_donation_nag = true;
        enforce_permissions = true;
      };

      permission = [
        "${osConfig.programs.hyprland.portalPackage}/libexec/.xdg-desktop-portal-hyprland-wrapped, screencopy, allow"
        "${getExe pkgs.grim}, screencopy, allow"
        "${getExe pkgs.hyprlock}, screencopy, allow"
        "${getExe pkgs.hyprpicker}, screencopy, allow"
        "${getExe pkgs.quickshell}, screencopy, allow"
        "${getExe pkgs.wl-screenrec}, screencopy, allow"
        "${pkgs.hyprlandPlugins.hypr-dynamic-cursors}/lib/libhypr-dynamic-cursors.so, plugin, allow"
        ".*, plugin, deny"
      ]
      ++ optionals (osConfig.myOptions.kbPermission != null) [
        "${osConfig.myOptions.kbPermission}, keyboard, allow"
        ".*, keyboard, deny"
      ];

      "plugin:dynamic-cursors".mode = "stretch";
    };
  };
}
