{
  lib,
  osConfig,
  ...
}:
let
  inherit (lib.modules) mkIf;
in
{
  wayland.windowManager.hyprland.settings = {
    monitor = osConfig.myOptions.monitor;

    windowrule = [
      "center, class:.*."
      "opacity 0.97 0.97 1.0, class:.*."
      "opacity 1.0, class:^steam.*|rpg_rt.exe|imv|mpv|org.wezfurlong.wezterm|firefox|brave-browser|swappy"
      "float, class:rpg_rt.exe|org.pulseaudio.pavucontrol|nm-connection-editor|xdg-desktop-portal-gtk"
      "size 40% 50%, class:org.pulseaudio.pavucontrol|nm-connection-editor"
      "size 50% 60%, class:xdg-desktop-portal-gtk"
      "pin, class:org.gnupg.pinentry-qt"
      "stayfocused, class:org.gnupg.pinentry-qt"
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

    workspace = mkIf (!osConfig.myOptions.isLaptop) [
      "1, monitor:HDMI-A-1, default:true"
      "2, monitor:DP-1, default:true"
    ];
  };
}
