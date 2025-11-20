{
  config,
  lib,
  osConfig,
  pkgs,
  ...
}:
let
  inherit (lib.meta) getExe;

  runOnce = program: "pgrep ${program} || uwsm-app -- ${program}";
in
{
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";
    bind = [
      "$mod, RETURN, exec, ${getExe pkgs.ghostty} +new-window"
      "$mod, B, exec, uwsm-app -- firefox"
      "SUPER_SHIFT, B, exec, uwsm-app -- brave"
      "SUPER_SHIFT, C, exec, ${runOnce "hyprpicker"} | wl-copy"
      "$mod, F, togglefloating"
      "SUPER_SHIFT, F, fullscreenstate, 3 1"
      "$mod, O, exec, uwsm-app -- ocr eng"
      "SUPER_SHIFT, O, exec, uwsm-app -- ocr jpn"
      "$mod, P, pseudo"
      "$mod, Q, killactive"
      "SUPER_SHIFT, Q, exec, hyprctl kill"
      "SUPER_SHIFT, S, exec, grimblast --notify copy area"
      "$mod, H, movefocus, l"
      "$mod, L, movefocus, r"
      "$mod, K, movefocus, u"
      "$mod, J, movefocus, d"
      "SUPER_SHIFT, H, movewindow, l"
      "SUPER_SHIFT, L, movewindow, r"
      "SUPER_SHIFT, K, movewindow, u"
      "SUPER_SHIFT, J, movewindow, d"

      "$mod, D, exec, dms ipc call spotlight toggle"
      "SUPER_SHIFT, E, exec, dms ipc call powermenu toggle"
      "$mod, M, exec, dms ipc call processlist toggle"
      "SUPER_SHIFT, N, exec, dms ipc call notepad toggle"
      "$mod, N, exec, dms ipc call notifications toggle"
      "$mod, T, exec, dms ipc call theme toggle"
      "$mod, V, exec, dms ipc call clipboard toggle"
      "$mod, W, exec, dms ipc call dankdash wallpaper"
      "$mod, comma, exec, dms ipc call settings toggle"
      "$mod, TAB, exec, dms ipc call hypr toggleOverview"

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
      ", XF86AudioRaiseVolume, exec, dms ipc call audio increment 5"
      ", XF86AudioLowerVolume, exec, dms ipc call audio decrement 5"
      "$mod, F6, exec, dms ipc call audio increment 5"
      "$mod, F5, exec, dms ipc call audio decrement 5"
      ", XF86MonBrightnessUp, exec, dms ipc call brightness increment 5 \"\""
      ", XF86MonBrightnessDown, exec, dms ipc call brightness decrement 5 \"\""
    ];

    bindl = [
      ", XF86AudioMute, exec, dms ipc call audio mute"
      "$mod, F4, exec, exec, dms ipc call audio mute"
      ", XF86AudioMicMute, exec, dms ipc call audio micmute"
      ", XF86AudioPause, exec, dms ipc call mpris playPause"
      ", XF86AudioPlay, exec, dms ipc call mpris playPause"
      ", XF86AudioPrev, exec, playerctl position -5"
      ", XF86AudioNext, exec, playerctl position +5"
    ];

    bindlo = [
      ", XF86AudioPrev, exec, dms ipc call mpris previous"
      ", XF86AudioNext, exec, dms ipc call mpris next"
    ];

    bindm = [
      "$mod, mouse:273, resizewindow"
      "$mod, mouse:272, movewindow"
    ];

    gesture = [
      "3, horizontal, workspace"
      "3, up, fullscreen"
      "3, down, float"
    ];
  };
}
