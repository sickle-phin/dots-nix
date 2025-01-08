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
      "center, .*."
      "opacity 0.97 0.97 1.0, .*."
      "opacity 1.0, ^steam.*|imv|mpv|org.wezfurlong.wezterm|firefox|brave-browser|swappy"
      "float, org.pulseaudio.pavucontrol|nm-connection-editor|xdg-desktop-portal-gtk"
      "size 40% 50%, org.pulseaudio.pavucontrol|nm-connection-editor"
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

    workspace = mkIf (!osConfig.myOptions.isLaptop) [
      "1, monitor:HDMI-A-1, default:true"
      "2, monitor:DP-1, default:true"
    ];
  };
}
