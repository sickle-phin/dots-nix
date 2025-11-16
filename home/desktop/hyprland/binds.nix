{
  config,
  dmsPkgs,
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
      "$mod, N, exec, ${getExe pkgs.quickshell} ipc call bar toggleNotificationCenter"
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

      "$mod, D, exec, ${getExe dmsPkgs.dmsCli} ipc call spotlight toggle"
      "SUPER_SHIFT, E, exec, ${getExe dmsPkgs.dmsCli} ipc call powermenu toggle"
      "$mod, M, exec, ${getExe dmsPkgs.dmsCli} ipc call processlist toggle"
      "SUPER_SHIFT, N, exec, ${getExe dmsPkgs.dmsCli} ipc call notepad toggle"
      "$mod, N, exec, ${getExe dmsPkgs.dmsCli} ipc call notifications toggle"
      "$mod, T, exec, ${getExe dmsPkgs.dmsCli} ipc call theme toggle"
      "$mod, V, exec, ${getExe dmsPkgs.dmsCli} ipc call clipboard toggle"
      "$mod, W, exec, ${getExe dmsPkgs.dmsCli} ipc call dankdash wallpaper"
      "$mod, comma, exec, ${getExe dmsPkgs.dmsCli} ipc call settings toggle"
      "$mod, TAB, exec, ${getExe dmsPkgs.dmsCli} ipc call hypr toggleOverview"

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

    bindel =
      let
        backlight =
          if (osConfig.myOptions.gpu.vendor == "intel") then
            "intel_backlight"
          else if (osConfig.myOptions.gpu.vendor == "nvidia") then
            "nvidia_0"
          else
            "amdgpu_bl1";
      in
      [
        ", XF86AudioRaiseVolume, exec, ${getExe dmsPkgs.dmsCli} ipc call audio increment 5"
        ", XF86AudioLowerVolume, exec, ${getExe dmsPkgs.dmsCli} ipc call audio decrement 5"
        "$mod, F6, exec, ${getExe dmsPkgs.dmsCli} ipc call audio increment 5"
        "$mod, F5, exec, ${getExe dmsPkgs.dmsCli} ipc call audio decrement 5"
        ", XF86MonBrightnessUp, exec, ${getExe dmsPkgs.dmsCli} ipc call brightness increment 5 backlight:${backlight}"
        ", XF86MonBrightnessDown, exec, ${getExe dmsPkgs.dmsCli} ipc call brightness decrement 5 backlight:${backlight}"
      ];

    bindl = [
      ", XF86AudioMute, exec, ${getExe dmsPkgs.dmsCli} ipc call audio mute"
      "$mod, F4, exec, exec, ${getExe dmsPkgs.dmsCli} ipc call audio mute"
      ", XF86AudioMicMute, exec, ${getExe dmsPkgs.dmsCli} ipc call audio micmute"
      ", XF86AudioPause, exec, ${getExe dmsPkgs.dmsCli} ipc call mpris playPause"
      ", XF86AudioPlay, exec, ${getExe dmsPkgs.dmsCli} ipc call mpris playPause"
      ", XF86AudioPrev, exec, playerctl position -5"
      ", XF86AudioNext, exec, playerctl position +5"
    ];

    bindlo = [
      ", XF86AudioPrev, exec, ${getExe dmsPkgs.dmsCli} ipc call mpris previous"
      ", XF86AudioNext, exec, ${getExe dmsPkgs.dmsCli} ipc call mpris next"
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
