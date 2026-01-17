{
  config,
  lib,
  osConfig,
  pkgs,
  ...
}:
let
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
      # pkgs.hyprlandPlugins.hypr-dynamic-cursors
    ];

    settings = {
      source = [ "${config.xdg.configHome}/hypr/dms/outputs.conf" ];

      input = {
        kb_layout = osConfig.myOptions.kbLayout;
        kb_options = "ctrl:nocaps";

        touchpad = {
          natural_scroll = false;
          scroll_factor = 0.2;
        };

        repeat_delay = 250;
        repeat_rate = 60;
      };

      gestures.workspace_swipe_distance = 1000;

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

      cursor = {
        min_refresh_rate = mkIf (host == "irukaha") 48;
        default_monitor = mkIf (!osConfig.myOptions.isLaptop) "DP-1";
      };

      ecosystem = {
        no_update_news = true;
        no_donation_nag = true;
        enforce_permissions = true;
      };

      plugin = {
        dynamic-cursors.mode = "stretch";
        hyprfocus.mode = "flash";
        hyprfocus.fade_opacity = "0.9";
      };
    };
  };
}
