{
  config,
  lib,
  osConfig,
  pkgs,
  ...
}:
let
  inherit (lib.meta) getExe;

  setCursor = "XCURSOR_THEME=$(cat ${config.xdg.cacheHome}/theme/cursor_theme) && XCURSOR_SIZE=$(cat ${config.xdg.cacheHome}/theme/xcursor_size)";
  runOnce = program: "pgrep ${program} || uwsm-app -- ${program}";
in
{
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";
    bind = [
      "$mod, RETURN, exec, ${setCursor}; uwsm-app -- ${getExe pkgs.wezterm}"
      "$mod, B, exec, uwsm-app -- firefox"
      "SUPER_SHIFT, B, exec, LANG=ja_JP.UTF8 uwsm-app -- brave"
      "SUPER_SHIFT, C, exec, ${runOnce "hyprpicker"} | wl-copy"
      "$mod, D, exec, ${setCursor}; pkill fuzzel || uwsm-app -- fuzzel"
      "SUPER_SHIFT, E, exec, ${getExe pkgs.quickshell} ipc call powerpanel toggle"
      "$mod, F, togglefloating"
      "SUPER_SHIFT, F, fullscreenstate, 3 1"
      "$mod, M, exec, ${setCursor}; LANG=ja_JP.UTF-8 uwsm-app -- ${pkgs.mozc}/lib/mozc/mozc_tool --mode=word_register_dialog"
      "$mod, O, exec, uwsm-app -- ocr eng"
      "SUPER_SHIFT, O, exec, uwsm-app -- ocr jpn"
      "$mod, P, pseudo"
      "$mod, Q, killactive"
      "SUPER_SHIFT, S, exec, grimblast --notify copy area"
      "$mod, T, exec, uwsm-app -- set-theme"
      "$mod, V, exec, pkill fuzzel || uwsm-app -- cliphist-fuzzel-img"
      "$mod, W, exec, ${getExe pkgs.quickshell} ipc call wallpaper toggle"
      "SUPER_SHIFT, Q, exec, hyprctl kill"
      "$mod, H, movefocus, l"
      "$mod, L, movefocus, r"
      "$mod, K, movefocus, u"
      "$mod, J, movefocus, d"
      "SUPER_SHIFT, H, movewindow, l"
      "SUPER_SHIFT, L, movewindow, r"
      "SUPER_SHIFT, K, movewindow, u"
      "SUPER_SHIFT, J, movewindow, d"
      ", Print, exec, grimblast save output - | swappy -f -"
      "Shift, Print, exec, grimblast save active - | swappy -f -"
      "$mod, Print, exec, pkill wl-screenrec || uwsm-app -- wl-screenrec -f \"${config.home.homeDirectory}/Videos/Screencasts/$(date +%Y%m%d_%H%M%S).mp4\""
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
      ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
      ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ", XF86MonBrightnessUp, exec, brightnessctl -n s 5%+"
      ", XF86MonBrightnessDown, exec, brightnessctl -n s 5%-"
    ];

    bindl = [
      ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
      ", XF86AudioPause, exec, playerctl play-pause"
      ", XF86AudioPlay, exec, playerctl play-pause"
      ", XF86AudioPrev, exec, playerctl previous"
      ", XF86AudioNext, exec, playerctl position +5"
    ];

    bindlo = [ ", XF86AudioNext, exec, playerctl next" ];

    bindm = [
      "$mod, mouse:273, resizewindow"
      "$mod, mouse:272, movewindow"
    ];
  };
}
