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

  host = osConfig.networking.hostName;
in
{
  xdg.configFile."uwsm/env".source =
    "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh";

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
    plugins = [
      pkgs.hyprlandPlugins.hypr-dynamic-cursors
      pkgs.hyprlandPlugins.hyprfocus
    ];
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
        enable_anr_dialog = true;
        anr_missed_pings = 15;
      };

      xwayland = {
        force_zero_scaling = true;
      };

      render = {
        direct_scanout = 1;
        cm_fs_passthrough = 1;
        new_render_scheduling = true;
      };

      experimental = {
        xx_color_management_v4 = false;
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
        "${getExe pkgs.hyprpicker}, screencopy, allow"
        "${getExe pkgs.wl-screenrec}, screencopy, allow"
        "${getExe' config.programs.dankMaterialShell.quickshell.package ".quickshell-wrapped"}, screencopy, allow"
        "${pkgs.hyprlandPlugins.hypr-dynamic-cursors}/lib/libhypr-dynamic-cursors.so, plugin, allow"
        "${pkgs.hyprlandPlugins.hyprfocus}/lib/libhyprfocus.so, plugin, allow"
        ".*, plugin, deny"
      ]
      ++ optionals (osConfig.myOptions.kbPermission != null) [
        "${osConfig.myOptions.kbPermission}, keyboard, allow"
        ".*, keyboard, deny"
      ];

      plugin = {
        dynamic-cursors.mode = "stretch";
        hyprfocus.mode = "flash";
        hyprfocus.fade_opacity = "0.9";
      };
    };
  };
}
