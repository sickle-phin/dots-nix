{ lib, osConfig, ... }:
with lib;
let
  gpu = osConfig.myOptions.gpu;
  host = osConfig.networking.hostName;
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    catppuccin.enable = true;
    settings = {
      env = [
        "NIXOS_OZONE_WL, 1"
        "GTK_IM_MODULE,"
        "GDK_BACKEND, wayland,x11"
        "QT_QPA_PLATFORM, wayland;xcb"
        "QT_AUTO_SCREEN_SCALE_FACTOR, 1"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION, 1"
        "MOZ_ENABLE_WAYLAND, 1"
        "SDL_VIDEODRIVER, wayland"
        "CLUTTER_BACKEND, wayland"
        "SWWW_TRANSITION, center"
        "SWWW_TRANSITION_FPS, ${toString osConfig.myOptions.maxFramerate}"
        "SWWW_TRANSITION_STEP, 255"
        "XDG_SESSION_DESKTOP, Hyprland"
        "HYPRCURSOR_THEME, catppuccin-mocha-dark-cursors"
        "HYPRCURSOR_SIZE, 30"
        "XCURSOR_THEME, catppuccin-mocha-dark-cursors"
        "XCURSOR_SIZE, 30"
      ];

      exec-once = [
        "swww query || swww-daemon"
        "pidof waybar || waybar"
        "slack --enable-wayland-ime --startup"
      ];

      monitor = osConfig.myOptions.monitor;

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

      general = {
        gaps_in = 7.5;
        gaps_out = 15;
        border_size = 3;
        "col.active_border" = "rgba($mauveAlphaee)";
        "col.inactive_border" = "rgba($surface2Alphadd)";

        resize_on_border = true;
        extend_border_grab_area = 30;

        layout = "dwindle";
      };

      dwindle = {
        force_split = 2;
      };

      decoration = {
        rounding = 10;

        blur = {
          enabled = false;
          size = 6;
          passes = 1;
          ignore_opacity = true;
        };

        drop_shadow = true;
        shadow_range = 20;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";
      };

      animations = {
        enabled = "yes";
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 5, myBezier, slide"
          "windowsOut, 1, 16, default, slide"
          "border, 1, 15, default"
          "borderangle, 1, 8, default"
          "fade, 1, 3, default"
          "fadeDim, 1, 80, default"
          "workspaces, 1, 6, default"
        ];
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
        swallow_regex = "foot";
        vrr = 1;
      };

      xwayland = {
        force_zero_scaling = true;
      };

      render = {
        explicit_sync = 1;
        explicit_sync_kms = if (gpu == "nvidia") then 0 else 1;
        direct_scanout = true;
      };

      windowrule = [
        "center, [\\s\\S]"
        "opacity 0.95 0.95 1.0, [\\s\\S]"
        "opacity 1.0, ^steam.*|imv|foot|org.wezfurlong.wezterm|firefox"
        "float, pavucontrol|.blueman-manager-wrapped"
        "size 700 500, pavucontrol|.blueman-manager-wrapped"
        "float, polkit-gnome-authentication-agent-1"
      ];

      windowrulev2 = [
        "stayfocused, title:^()$,class:^(steam)$"
        "minsize 1 1, title:^()$,class:^(steam)$"
        "noshadow, floating:0"
        "animation popin, floating:1"
      ];

      "$mod" = "SUPER";
      bind =
        [
          "$mod, RETURN, exec, foot"
          "$mod, B, exec, firefox"
          "$mod, C, exec, pidof hyprpicker || hyprpicker | wl-copy"
          "SUPER_SHIFT, E, exec, pidof wlogout || wlogout -b 6 -T 400 -B 400"
          "$mod, D, exec, rofi -show drun"
          "$mod, F, togglefloating"
          "SUPER_SHIFT, F, fullscreen, 0"
          "$mod, O, exec, ${../scripts/hypr_option.sh}"
          "$mod, S, exec, hyprshot -m output"
          "SUPER_SHIFT, S, exec, hyprshot -m region --clipboard-only"
          "$mod, T, exec, ${../scripts/ocr.sh} eng"
          "SUPER_SHIFT, T, exec, ${../scripts/ocr.sh} jpn"
          "$mod, P, pseudo"
          "$mod, V, exec, cliphist list | rofi -dmenu -p \" 󱘞 Clipboard \" | cliphist decode | wl-copy"
          "$mod, Q, killactive"
          "SUPER_SHIFT, Q, exec, hyprctl kill"
          "$mod, W, exec, set-wallpaper"
          ", XF86AudioMute, exec, ${../scripts/volume.sh} --toggle"
          ", XF86AudioLowerVolume, exec, ${../scripts/volume.sh} --dec"
          ", XF86AudioRaiseVolume, exec, ${../scripts/volume.sh} --inc"
          ", XF86MonBrightnessDown, exec, ${../scripts/backlight.sh} --dec"
          ", XF86MonBrightnessUp, exec, ${../scripts/backlight.sh} --inc"
          "$mod, H, movefocus, l"
          "$mod, L, movefocus, r"
          "$mod, K, movefocus, u"
          "$mod, J, movefocus, d"
          "SUPER_SHIFT, H, movewindow, l"
          "SUPER_SHIFT, L, movewindow, r"
          "SUPER_SHIFT, K, movewindow, u"
          "SUPER_SHIFT, J, movewindow, d"
          "$mod, mouse_down, workspace, e+1"
          "$mod, mouse_up, workspace, e-1"
        ]
        ++ (
          # workspaces
          # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
          builtins.concatLists (
            builtins.genList (
              x:
              let
                ws =
                  let
                    c = (x + 1) / 10;
                  in
                  builtins.toString (x + 1 - (c * 10));
              in
              [
                "$mod, ${ws}, workspace, ${toString (x + 1)}"
                "$mod SHIFT, ${ws}, movetoworkspacesilent, ${toString (x + 1)}"
              ]
            ) 10
          )
        );

      bindm = [
        "$mod, mouse:273, resizewindow"
        "$mod, mouse:272, movewindow"
      ];

      cursor = {
        no_hardware_cursors = mkIf (gpu == "nvidia") true;
        no_break_fs_vrr = true;
        min_refresh_rate = mkIf (host == "irukaha") 48;
        default_monitor = mkIf (host == "irukaha") "DP-1";
      };
    };
  };
}
