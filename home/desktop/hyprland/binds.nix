{
  config,
  osConfig,
  pkgs,
  ...
}:
let
  setCursor = "XCURSOR_THEME=$(cat ${config.xdg.cacheHome}/theme/cursor_theme) && XCURSOR_SIZE=$(cat ${config.xdg.cacheHome}/theme/cursor_size)";
  toggle =
    program:
    let
      prog = builtins.substring 0 14 program;
    in
    "pkill ${prog} || uwsm-app ${program}";

  runOnce = program: "pgrep ${program} || uwsm-app ${program}";
in
{
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";
    bind =
      [
        "$mod, RETURN, exec, ${setCursor}; uwsm-app foot"
        "$mod, B, exec, uwsm-app firefox"
        "SUPER_SHIFT, B, exec, LANG=ja_JP-UTF8 uwsm-app brave"
        "SUPER_SHIFT, C, exec, ${runOnce "hyprpicker"} | wl-copy"
        "SUPER_SHIFT, E, exec, uwsm-app wlogout-run"
        "$mod, D, exec, ${setCursor}; uwsm-app fuzzel"
        "$mod, F, togglefloating"
        "SUPER_SHIFT, F, fullscreen, 0"
        "$mod, m, exec, uwsm-app ${pkgs.mozc}/lib/mozc/mozc_tool --mode=word_register_dialog"
        "$mod, O, exec, uwsm-app ${../scripts/ocr.sh} eng"
        "SUPER_SHIFT, O, uwsm-app exec, ${../scripts/ocr.sh} jpn"
        "$mod, S, exec, ${runOnce "hyprshot -m output"}"
        "SUPER_SHIFT, S, exec, ${runOnce "hyprshot -m region --clipboard-only"}"
        "$mod, T, exec, uwsm-app set-theme"
        "$mod, P, pseudo"
        "$mod, U, exec, ${toggle "hyprsunset"}"
        "$mod, V, exec, uwsm-app cliphist list | fuzzel -d | cliphist decode | wl-copy"
        "$mod, Q, killactive"
        "SUPER_SHIFT, Q, exec, hyprctl kill"
        # "$mod, W, exec, ags -t wallpaper"
        "$mod, W, exec, uwsm-app set-wallpaper"
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
  };
}
