{
  config,
  inputs,
  lib,
  osConfig,
  pkgs,
  ...
}:
let
  inherit (lib.generators) mkLuaInline;
  inherit (lib.meta) getExe;
  inherit (lib.trivial) boolToString;
  dms = getExe config.programs.dank-material-shell.package;
  dcal = getExe inputs.dank-calendar.packages.${pkgs.stdenv.hostPlatform.system}.dankcalendar;
  mainMod = "SUPER";
in
{
  wayland.windowManager.hyprland.settings = {
    bind = [
      {
        _args = [
          "${mainMod} + F"
          (mkLuaInline "hl.dsp.window.float({ action = \"toggle\" })")
        ];
      }
      {
        _args = [
          "${mainMod} + SHIFT + F"
          (mkLuaInline "hl.dsp.window.fullscreen({ action = \"toggle\" })")
        ];
      }
      {
        _args = [
          "${mainMod} + Q"
          (mkLuaInline "hl.dsp.window.close()")
        ];
      }
      {
        _args = [
          "${mainMod} + SHIFT + Q"
          (mkLuaInline "hl.dsp.window.kill()")
        ];
      }
      {
        _args = [
          "${mainMod} + H"
          (mkLuaInline "hl.dsp.focus({ direction = \"left\" })")
        ];
      }
      {
        _args = [
          "${mainMod} + L"
          (mkLuaInline "hl.dsp.focus({ direction = \"right\" })")
        ];
      }
      {
        _args = [
          "${mainMod} + K"
          (mkLuaInline "hl.dsp.focus({ direction = \"up\" })")
        ];
      }
      {
        _args = [
          "${mainMod} + J"
          (mkLuaInline "hl.dsp.focus({ direction = \"down\" })")
        ];
      }
      {
        _args = [
          "${mainMod} + SHIFT + H"
          (mkLuaInline "hl.dsp.window.move({ direction = \"left\" })")
        ];
      }
      {
        _args = [
          "${mainMod} + SHIFT + L"
          (mkLuaInline "hl.dsp.window.move({ direction = \"right\" })")
        ];
      }
      {
        _args = [
          "${mainMod} + SHIFT + K"
          (mkLuaInline "hl.dsp.window.move({ direction = \"up\" })")
        ];
      }
      {
        _args = [
          "${mainMod} + SHIFT + J"
          (mkLuaInline "hl.dsp.window.move({ direction = \"down\" })")
        ];
      }
      {
        _args = [
          "${mainMod} + mouse_down"
          (mkLuaInline "hl.dsp.focus({ workspace = \"e-1\" })")
        ];
      }
      {
        _args = [
          "${mainMod} + mouse_up"
          (mkLuaInline "hl.dsp.focus({ workspace = \"e+1\" })")
        ];
      }
      {
        _args = [
          "${mainMod} + mouse:272"
          (mkLuaInline "hl.dsp.window.drag()")
          { mouse = true; }
        ];
      }
      {
        _args = [
          "${mainMod} + mouse:273"
          (mkLuaInline "hl.dsp.window.resize()")
          { mouse = true; }
        ];
      }
      {
        _args = [
          "${mainMod} + RETURN"
          (mkLuaInline "hl.dsp.exec_cmd(\"${getExe pkgs.ghostty} +new-window\")")
          { description = "Terminal"; }
        ];
      }
      {
        _args = [
          "${mainMod} + B"
          (mkLuaInline "hl.dsp.exec_cmd(\"uwsm-app -- ${getExe config.programs.firefox.finalPackage}\")")
          { description = "Firefox"; }
        ];
      }
      {
        _args = [
          "${mainMod} + SHIFT + B"
          (mkLuaInline "hl.dsp.exec_cmd(\"uwsm-app -- ${getExe config.programs.google-chrome.finalPackage}\")")
          { description = "Google Chrome"; }
        ];
      }
      {
        _args = [
          "${mainMod} + O"
          (mkLuaInline "hl.dsp.exec_cmd(\"uwsm-app -- ocr eng\")")
          { description = "OCR(English)"; }
        ];
      }
      {
        _args = [
          "${mainMod} + SHIFT + O"
          (mkLuaInline "hl.dsp.exec_cmd(\"uwsm-app -- ocr jpn\")")
          { description = "OCR(Japanese)"; }
        ];
      }
      {
        _args = [
          "${mainMod} + A"
          (mkLuaInline "hl.dsp.exec_cmd(\"${dms} ipc call widget toggle polyglot\")")
          { description = "Translation"; }
        ];
      }
      {
        _args = [
          "${mainMod} + C"
          (mkLuaInline "hl.dsp.exec_cmd(\"${dcal} toggle\")")
          { description = "Calendar"; }
        ];
      }
      {
        _args = [
          "${mainMod} + SHIFT + C"
          (mkLuaInline "hl.dsp.exec_cmd(\"${dms} color pick -a\")")
          { description = "Color Picker"; }
        ];
      }
      {
        _args = [
          "${mainMod} + D"
          (mkLuaInline "hl.dsp.exec_cmd(\"${dms} ipc call spotlight toggle\")")
          { description = "Launcher"; }
        ];
      }
      {
        _args = [
          "${mainMod} + SHIFT + E"
          (mkLuaInline "hl.dsp.exec_cmd(\"${dms} ipc call powermenu toggle\")")
          { description = "Power Menu"; }
        ];
      }
      {
        _args = [
          "${mainMod} + M"
          (mkLuaInline "hl.dsp.exec_cmd(\"${dms} ipc call processlist toggle\")")
          { description = "Process List"; }
        ];
      }
      {
        _args = [
          "${mainMod} + N"
          (mkLuaInline "hl.dsp.exec_cmd(\"${dms} ipc call notifications toggle\")")
          { description = "Notifications"; }
        ];
      }
      {
        _args = [
          "${mainMod} + SHIFT + N"
          (mkLuaInline "hl.dsp.exec_cmd(\"${dms} ipc call notepad toggle\")")
          { description = "Notepad"; }
        ];
      }
      {
        _args = [
          "${mainMod} + T"
          (mkLuaInline "hl.dsp.exec_cmd(\"${dms} ipc call theme toggle\")")
          { description = "Toggle Dark/Light Theme"; }
        ];
      }
      {
        _args = [
          "${mainMod} + V"
          (mkLuaInline "hl.dsp.exec_cmd(\"${dms} ipc call clipboard toggle\")")
          { description = "Clipboard History"; }
        ];
      }
      {
        _args = [
          "${mainMod} + W"
          (mkLuaInline "hl.dsp.exec_cmd(\"${dms} ipc wallpaperCarousel toggle\")")
          { description = "Wallpapers"; }
        ];
      }
      {
        _args = [
          "${mainMod} + Comma"
          (mkLuaInline "hl.dsp.exec_cmd(\"${dms} ipc call settings toggle\")")
          { description = "DMS Settings"; }
        ];
      }
      {
        _args = [
          "${mainMod} + Slash"
          (mkLuaInline "hl.dsp.exec_cmd(\"${dms} ipc call keybinds toggle hyprland\")")
          { description = "Hyprland Keybinds"; }
        ];
      }
      {
        _args = [
          "${mainMod} + Tab"
          (mkLuaInline "hl.dsp.exec_cmd(\"${dms} ipc call hypr toggleOverview\")")
          { description = "Overview"; }
        ];
      }
      {
        _args = [
          "${mainMod} + SHIFT + S"
          (mkLuaInline "hl.dsp.exec_cmd(\"${dms} screenshot --no-confirm --no-file --reset\")")
          { description = "Screenshot(Region)"; }
        ];
      }
      {
        _args = [
          "Print"
          (mkLuaInline "hl.dsp.exec_cmd(\"${dms} screenshot full --stdout | ${getExe config.programs.satty.package} -f -\")")
          { description = "Screenshot(Full)"; }
        ];
      }
      {
        _args = [
          "SHIFT + Print"
          (mkLuaInline "hl.dsp.exec_cmd(\"${dms} screenshot window --stdout | ${getExe config.programs.satty.package} -f -\")")
          { description = "Screenshot(Focused Window)"; }
        ];
      }
      {
        _args = [
          "${mainMod} + Print"
          (mkLuaInline "hl.dsp.exec_cmd(\"pkill wl-screenrec || uwsm-app -- ${getExe pkgs.wl-screenrec} -f \\\"${config.home.homeDirectory}/Videos/Screencasts/$(date +%Y%m%d_%H%M%S).mp4\\\"\")")
          { description = "Screencast"; }
        ];
      }
      {
        _args = [
          "XF86AudioRaiseVolume"
          (mkLuaInline "hl.dsp.exec_cmd(\"${dms} ipc call audio increment 5\")")
          {
            locked = true;
            repeating = true;
            description = "Audio Increment";
          }
        ];
      }
      {
        _args = [
          "XF86AudioLowerVolume"
          (mkLuaInline "hl.dsp.exec_cmd(\"${dms} ipc call audio decrement 5\")")
          {
            locked = true;
            repeating = true;
            description = "Audio Decrement";
          }
        ];
      }
      {
        _args = [
          "XF86MonBrightnessUp"
          (mkLuaInline "hl.dsp.exec_cmd(\"${dms} ipc call brightness increment 5 \\\"\\\"\")")
          {
            locked = true;
            repeating = true;
            description = "Brightness Increment";
          }
        ];
      }
      {
        _args = [
          "XF86MonBrightnessDown"
          (mkLuaInline "hl.dsp.exec_cmd(\"${dms} ipc call brightness decrement 5 \\\"\\\"\")")
          {
            locked = true;
            repeating = true;
            description = "Brightness Decrement";
          }
        ];
      }
      {
        _args = [
          "XF86AudioMute"
          (mkLuaInline "hl.dsp.exec_cmd(\"${dms} ipc call audio mute\")")
          {
            locked = true;
            description = "Audio Mute";
          }
        ];
      }
      {
        _args = [
          "XF86AudioMicMute"
          (mkLuaInline "hl.dsp.exec_cmd(\"${dms} ipc call audio micmute\")")
          {
            locked = true;
            description = "Mic Mute";
          }
        ];
      }
      {
        _args = [
          "XF86AudioPause"
          (mkLuaInline "hl.dsp.exec_cmd(\"${dms} ipc call mpris playPause\")")
          {
            locked = true;
            description = "Media(Play/Pause)";
          }
        ];
      }
      {
        _args = [
          "XF86AudioPlay"
          (mkLuaInline "hl.dsp.exec_cmd(\"${dms} ipc call mpris playPause\")")
          {
            locked = true;
            description = "Media(Play/Pause)";
          }
        ];
      }
      {
        _args = [
          "XF86AudioPrev"
          (mkLuaInline "hl.dsp.exec_cmd(\"${getExe pkgs.playerctl} position -5\")")
          {
            locked = true;
            description = "Media(Position -5sec)";
          }
        ];
      }
      {
        _args = [
          "XF86AudioNext"
          (mkLuaInline "hl.dsp.exec_cmd(\"${getExe pkgs.playerctl} position +5\")")
          {
            locked = true;
            description = "Media(Position +5sec)";
          }
        ];
      }
      {
        _args = [
          "XF86AudioPrev"
          (mkLuaInline "hl.dsp.exec_cmd(\"${dms} ipc call mpris previous\")")
          {
            locked = true;
            long_press = true;
            description = "Media(Skip to the Previous Track)";
          }
        ];
      }
      {
        _args = [
          "XF86AudioNext"
          (mkLuaInline "hl.dsp.exec_cmd(\"${dms} ipc call mpris next\")")
          {
            locked = true;
            long_press = true;
            description = "Media(Skip to the Next Track)";
          }
        ];
      }
    ]
    ++ (builtins.concatLists (
      builtins.genList (
        i:
        let
          ws = i + 1;
        in
        [
          {
            _args = [
              "${mainMod} + ${toString ws}"
              (mkLuaInline "hl.dsp.focus({ workspace = ${toString ws} })")
            ];
          }
          {
            _args = [
              "${mainMod} + SHIFT + ${toString ws}"
              (mkLuaInline "hl.dsp.window.move({ workspace = ${toString ws}, follow = ${
                boolToString (!osConfig.myOptions.isLaptop)
              } })")
            ];
          }
        ]
      ) 9
    ));

    gesture = [
      {
        fingers = 3;
        direction = "vertical";
        action = "scroll_move";
      }
      {
        fingers = 3;
        direction = "horizontal";
        action = "workspace";
      }
    ];
  };
}
