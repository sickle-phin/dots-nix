{
  config,
  inputs,
  lib,
  osConfig,
  pkgs,
  ...
}:
let
  inherit (lib.meta) getExe;
  dms = getExe inputs.dank-material-shell.packages.${pkgs.stdenv.hostPlatform.system}.dms-shell;
in
{
  wayland.windowManager.hyprland.settings = {
    source = [ "${config.xdg.configHome}/hypr/dms/binds.conf" ];
    "$mod" = "SUPER";
    bind = [
      "$mod, F, togglefloating"
      "SUPER_SHIFT, F, fullscreen"
      "$mod, P, pseudo"
      "$mod, Q, killactive"
      "SUPER_SHIFT, Q, forcekillactive"
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
              toString (x + 1 - (c * 10));
          in
          [
            "$mod, ${ws}, workspace, ${toString (x + 1)}"
            "$mod SHIFT, ${ws}, ${dispatch}, ${toString (x + 1)}"
          ]
        ) 10
      )
    );

    binde = [
      "$mod, minus, resizeactive, -10% 0"
      "$mod, equal, resizeactive, 10% 0"
      "$mod SHIFT, minus, resizeactive, 0 -10%"
      "$mod SHIFT, equal, resizeactive, 0 10%"
    ];

    bindd = [
      "$mod, RETURN, Terminal, exec, ${getExe pkgs.ghostty} +new-window"
      "$mod, B, Zen Browser, exec, uwsm-app -- ${getExe config.programs.firefox.finalPackage}"
      "SUPER_SHIFT, B, Google Chrome, exec, uwsm-app -- ${getExe config.programs.google-chrome.finalPackage}"
      "$mod, O, OCR(English), exec, uwsm-app -- ocr eng"
      "SUPER_SHIFT, O, OCR(Japanese), exec, uwsm-app -- ocr jpn"
      "$mod, A, Translation, exec, ${dms} ipc call widget toggle polyglot"
      "SUPER_SHIFT, C, Color Picker, exec, ${dms} color pick -a"
      "$mod, D, Launcher, exec, ${dms} ipc call spotlight toggle"
      "SUPER_SHIFT, E, Power Menu, exec, ${dms} ipc call powermenu toggle"
      "$mod, M, Process List, exec, ${dms} ipc call processlist toggle"
      "$mod, N, Notifications, exec, ${dms} ipc call notifications toggle"
      "SUPER_SHIFT, N, Notepad, exec, ${dms} ipc call notepad toggle"
      "$mod, T, Toggle Dark/Light Theme, exec, ${dms} ipc call theme toggle"
      "$mod, V, Clipboard History, exec, ${dms} ipc call clipboard toggle"
      "$mod, W, Wallpapers, exec, ${dms} ipc call dankdash wallpaper"
      "$mod, Comma, DMS Settings, exec, ${dms} ipc call settings toggle"
      "$mod, Slash, Hyprland Keybinds, exec, ${dms} ipc call keybinds toggle hyprland"
      "$mod, Tab, Overview, exec, ${dms} ipc call hypr toggleOverview"
      "SUPER_SHIFT, S, Screenshot(Region), exec, ${dms} screenshot --no-file"
      ", Print, Screenshot(Full), exec, ${dms} screenshot full --stdout | ${getExe pkgs.satty} -f -"
      "Shift, Print, Screenshot(Focused Window), exec, ${dms} screenshot window --stdout | ${getExe pkgs.satty} -f -"
      "$mod, Print, Screencast, exec, pkill wl-screenrec || uwsm-app -- ${getExe pkgs.wl-screenrec} -f \"${config.home.homeDirectory}/Videos/Screencasts/$(date +%Y%m%d_%H%M%S).mp4\""
    ];

    binddel = [
      ", XF86AudioRaiseVolume, Audio Increment, exec, ${dms} ipc call audio increment 5"
      ", XF86AudioLowerVolume, Audio Decrement, exec, ${dms} ipc call audio decrement 5"
      "$mod, F6, Audio Increment, exec, ${dms} ipc call audio increment 5"
      "$mod, F5, Audio Decrement, exec, ${dms} ipc call audio decrement 5"
      ", XF86MonBrightnessUp, Brightness Increment, exec, ${dms} ipc call brightness increment 5 \"\""
      ", XF86MonBrightnessDown, Brightness Decrement, exec, ${dms} ipc call brightness decrement 5 \"\""
    ];

    binddl = [
      ", XF86AudioMute, Audio Mute, exec, ${dms} ipc call audio mute"
      "$mod, F4, Audio Mute, exec, ${dms} ipc call audio mute"
      ", XF86AudioMicMute, Mic Mute, exec, ${dms} ipc call audio micmute"
      ", XF86AudioPause, Media(Play/Pause), exec, ${dms} ipc call mpris playPause"
      ", XF86AudioPlay, Media(Play/Pause), exec, ${dms} ipc call mpris playPause"
      ", XF86AudioPrev, Media(Position -5sec), exec, ${getExe pkgs.playerctl} position -5"
      ", XF86AudioNext, Media(Position +5sec), exec, ${getExe pkgs.playerctl} position +5"
    ];

    binddlo = [
      ", XF86AudioPrev, Media(Skip to the Previous Track), exec, ${dms} ipc call mpris previous"
      ", XF86AudioNext, Media(Skip to the Next Track), exec, ${dms} ipc call mpris next"
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
