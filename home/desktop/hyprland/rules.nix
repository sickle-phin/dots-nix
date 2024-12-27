{
  lib,
  osConfig,
  ...
}:
let
  gpu = osConfig.myOptions.gpu;
  host = osConfig.networking.hostName;
in
{
  wayland.windowManager.hyprland.settings = {
    monitor = osConfig.myOptions.monitor;

    windowrule = [
      "center, [\\s\\S]"
      "opacity 0.97 0.97 1.0, [\\s\\S]"
      "opacity 1.0, ^steam.*|imv|mpv|kitty|com.mitchellh.ghostty|org.wezfurlong.wezterm|firefox|brave-browser|swappy"
      "float, org.pulseaudio.pavucontrol|.blueman-manager-wrapped|nm-connection-editor|xdg-desktop-portal-gtk"
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

    workspace = lib.mkIf (!osConfig.myOptions.isLaptop) [
      "1, monitor:HDMI-A-1, default:true"
      "2, monitor:DP-1, default:true"
    ];
  };
}
