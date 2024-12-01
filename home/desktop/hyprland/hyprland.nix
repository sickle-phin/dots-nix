{
  config,
  lib,
  osConfig,
  pkgs,
  ...
}:
let
  gpu = osConfig.myOptions.gpu;
  host = osConfig.networking.hostName;
  toggle =
    program:
    let
      prog = builtins.substring 0 14 program;
    in
    "pkill ${prog} || uwsm app -- ${program}";

  runOnce = program: "pgrep ${program} || uwsm app -- ${program}";
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    catppuccin.enable = true;
    systemd.enable = false;
    settings = {
      exec-once = [
        "cursor_cache=$(cat ${config.xdg.cacheHome}/hypr/cursor) && hyprctl setcursor \"$cursor_cache\" 32"
        "border_cache=$(cat ${config.xdg.cacheHome}/hypr/border) && hyprctl keyword general:col.active_border \"$border_cache\""
        "uwsm finalize"
        "uwsm app -- swww-daemon"
        # "ags"
        "uwsm app -- waybar"
        "uwsm app -- hyprsunset"
        "uwsm app -- slack --enable-wayland-ime --startup"
        "uwsm app -- ${lib.getExe pkgs.wl-clip-persist} --clipboard regular"
        "dconf write /org/gnome/desktop/interface/font-name \"'Noto Sans CJK JP 11'\""
      ];

      exec-shutdown = [
        "${pkgs.wl-clipboard}/bin/cliphist wipe"
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
        "col.active_border" = "rgba($pinkAlphaee)";
        "col.inactive_border" = "rgba($surface2Alphadd)";

        resize_on_border = true;
        extend_border_grab_area = 30;

        layout = "dwindle";

        allow_tearing = true;
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

        shadow = {
          enabled = true;
          range = 20;
          render_power = 3;
        };
      };

      animations = {
        enabled = "yes";
        bezier = [
          # "myBezier, 0.05, 0.9, 0.1, 1.05"
          "wind, 0.05, 0.9, 0.1, 1"
          "winIn, 0.1, 1, 0.1, 1"
          "winOut, 0.3, -0.3, 0, 1"
          "liner, 1, 1, 1, 1"
        ];
        animation = [
          "windows, 1, 5, wind, slide"
          "windowsIn, 1, 5, winIn, slide"
          "windowsOut, 1, 5, winOut, slide"
          "windowsMove, 1, 5, wind, slide"
          "border, 1, 1, liner"
          "borderangle, 1, 8, default"
          # "borderangle, 1, 30, liner, loop"
          "fade, 1, 3, default"
          "workspaces, 1, 5, wind"
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
        explicit_sync_kms = 1;
        direct_scanout = true;
      };

      windowrule = [
        "center, [\\s\\S]"
        "opacity 0.97 0.97 1.0, [\\s\\S]"
        "opacity 1.0, ^steam.*|imv|foot|org.wezfurlong.wezterm|firefox|brave-browser|swappy"
        "float, pavucontrol|.blueman-manager-wrapped|nm-connection-editor|xdg-desktop-portal-gtk"
        "size 40% 50%, pavucontrol|.blueman-manager-wrapped|nm-connection-editor"
        "size 50% 60%, xdg-desktop-portal-gtk"
        "pin, org.gnupg.pinentry-qt"
        "stayfocused, org.gnupg.pinentry-qt"
      ];

      windowrulev2 = [
        "stayfocused, title:^()$,class:^(steam)$"
        "minsize 1 1, title:^()$,class:^(steam)$"
        "noshadow, floating:0"
        "animation popin, floating:1"
        "keepaspectratio, title:^(Picture-in-Picture|ピクチャーインピクチャー)$"
        "move 72% 7%,title:^(Picture-in-Picture|ピクチャーインピクチャー)$"
        "size 25%, title:^(Picture-in-Picture|ピクチャーインピクチャー)$"
        "float, title:^(Picture-in-Picture|ピクチャーインピクチャー)$"
        "pin, title:^(Picture-in-Picture|ピクチャーインピクチャー)$"
        "immediate, class:^steam.*"
        "pin, title:^(Hyprland Polkit Agent)$"
        "stayfocused, title:^(Hyprland Polkit Agent)$"
      ];

      "$mod" = "SUPER";
      bind =
        [
          "$mod, RETURN, exec, uwsm app -- foot"
          "$mod, B, exec, uwsm app -- firefox"
          "SUPER_SHIFT, B, exec, LANG=ja_JP-UTF8 uwsm app -- brave"
          "SUPER_SHIFT, C, exec, ${runOnce "hyprpicker"} | wl-copy"
          "SUPER_SHIFT, E, exec, uwsm app -- wlogout-run"
          "$mod, D, exec, uwsm app -- rofi -show drun"
          "$mod, F, togglefloating"
          "SUPER_SHIFT, F, fullscreen, 0"
          "$mod, m, exec, ${pkgs.mozc}/lib/mozc/mozc_tool --mode=word_register_dialog"
          "$mod, O, exec, ${../scripts/ocr.sh} eng"
          "SUPER_SHIFT, O, exec, ${../scripts/ocr.sh} jpn"
          "$mod, S, exec, ${runOnce "hyprshot -m output"}"
          "SUPER_SHIFT, S, exec, ${runOnce "hyprshot -m region --clipboard-only"}"
          "$mod, T, exec, uwsm app -- set-theme"
          "$mod, P, pseudo"
          "$mod, U, exec, ${toggle "hyprsunset"}"
          "$mod, V, exec, uwsm app -- cliphist list | rofi -dmenu -p \" 󱘞 Clipboard \" | cliphist decode | wl-copy"
          "$mod, Q, killactive"
          "SUPER_SHIFT, Q, exec, hyprctl kill"
          # "$mod, W, exec, ags -t wallpaper"
          "$mod, W, exec, uwsm app -- set-wallpaper"
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
          let
            dispatch = if osConfig.myOptions.isLaptop then "movetoworkspacesilent" else "movetoworkspace";
          in
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
                "$mod SHIFT, ${ws}, ${dispatch}, ${toString (x + 1)}"
              ]
            ) 10
          )
        );

      bindel = [
        ", XF86AudioLowerVolume, exec, ${../scripts/volume.sh} --dec"
        ", XF86AudioRaiseVolume, exec, ${../scripts/volume.sh} --inc"
        ", XF86MonBrightnessDown, exec, ${../scripts/backlight.sh} --dec"
        ", XF86MonBrightnessUp, exec, ${../scripts/backlight.sh} --inc"
      ];

      bindl = [
        ", XF86AudioMute, exec, ${../scripts/volume.sh} --toggle"
        ", XF86AudioMicMute, exec, ${../scripts/volume.sh} --toggle-mic"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
        ", XF86AudioNext, exec, playerctl next"
      ];

      bindm = [
        "$mod, mouse:273, resizewindow"
        "$mod, mouse:272, movewindow"
      ];

      cursor = {
        no_hardware_cursors = lib.mkIf (gpu == "nvidia") true;
        no_break_fs_vrr = true;
        min_refresh_rate = lib.mkIf (host == "irukaha") 48;
        default_monitor = lib.mkIf (host == "irukaha") "DP-1";
      };
    };
  };
}
