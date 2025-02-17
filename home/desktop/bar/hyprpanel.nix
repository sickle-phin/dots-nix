{
  inputs,
  lib,
  osConfig,
  pkgs,
  ...
}:
let
  inherit (lib.strings) replaceStrings;
  inherit (lib.trivial) boolToString;

  location = "${inputs.mysecrets}/location";
  weatherKey = "${inputs.mysecrets}/weather-key";
  defaultMonitor =
    if (osConfig.networking.hostName == "irukaha" || osConfig.networking.hostName == "labo") then
      "1"
    else
      "0";
in
{
  home.packages = [
    pkgs.hyprpanel
  ];

  xdg.configFile."hyprpanel/template.json".text = ''
    {
      "bar.autoHide": "fullscreen",
      "bar.battery.label": ${boolToString osConfig.myOptions.isLaptop},
      "bar.bluetooth.label": false,
      "bar.clock.format": "%a %b %d  %-H:%M",
      "bar.layouts": {
        "${defaultMonitor}": {
          "left": [
            "dashboard",
            "workspaces",
            "windowtitle"
          ],
          "middle": [
            "clock"
          ],
          "right": [
            "volume",
            "network",
            "bluetooth",
            "battery",
            "systray",
            "notifications"
          ]
        },
        "*": {
          "left": [
          ],
          "middle": [
          ],
          "right": [
          ]
        }
      },
      "bar.launcher.icon": "",
      "bar.network.label": false,
      "bar.network.showWifiInfo": true,
      "bar.network.truncation_size": 15,
      "bar.volume.rightClick": "uwsm-app -- pavucontrol",
      "bar.workspaces.applicationIconOncePerWorkspace": false,
      "bar.workspaces.showApplicationIcons": true,
      "bar.workspaces.showWsIcons": true,
      "bar.workspaces.workspaces": 0,
      "menus.clock.time.hideSeconds": false,
      "menus.clock.time.military": true,
      "menus.clock.weather.key": "${replaceStrings [ "\n" ] [ "" ] (builtins.readFile weatherKey)}",
      "menus.clock.weather.location": "${replaceStrings [ "\n" ] [ "" ] (builtins.readFile location)}",
      "menus.clock.weather.unit": "metric",
      "menus.dashboard.powermenu.avatar.image": "${../icons/sickle-phin.png}",
      "menus.dashboard.powermenu.logout": "uwsm stop",
      "menus.dashboard.shortcuts.left.shortcut1.command": "uwsm-app -- fuzzel",
      "menus.dashboard.shortcuts.left.shortcut1.icon": "",
      "menus.dashboard.shortcuts.left.shortcut1.tooltip": "Search Apps",
      "menus.dashboard.shortcuts.left.shortcut2.command": "uwsm-app -- set-theme",
      "menus.dashboard.shortcuts.left.shortcut2.icon": "󰔎",
      "menus.dashboard.shortcuts.left.shortcut2.tooltip": "Set Theme",
      "menus.dashboard.shortcuts.left.shortcut3.command": "uwsm-app -- set-option",
      "menus.dashboard.shortcuts.left.shortcut3.icon": "",
      "menus.dashboard.shortcuts.left.shortcut3.tooltip": "Hyprland Options",
      "menus.dashboard.shortcuts.left.shortcut4.command": "uwsm-app -- set-wallpaper",
      "menus.dashboard.shortcuts.left.shortcut4.icon": "",
      "menus.dashboard.shortcuts.left.shortcut4.tooltip": "Set Wallpaper",
      "menus.dashboard.shortcuts.right.shortcut1.command": "loginctl lock-session",
      "menus.dashboard.shortcuts.right.shortcut1.icon": "󰌾",
      "menus.dashboard.shortcuts.right.shortcut1.tooltip": "Lock Screen",
      "menus.dashboard.stats.enable_gpu": ${boolToString (osConfig.myOptions.gpu == "nvidia")},
      "menus.power.confirmation": false,
      "menus.power.logout": "uwsm stop",
      "menus.power.lowBatteryNotification": true,
      "notifications.position": "bottom right",
      "tear": false,
      "terminal": "wezterm",
      "theme.bar.buttons.padding_y": "0.3rem",
      "theme.bar.buttons.y_margins": "0.0em",
      "theme.bar.floating": true,
      "theme.bar.layer": "bottom",
      "theme.bar.margin_sides": "1.0em",
      "theme.bar.outer_spacing": "0em",
      "theme.bar.scaling": 90,
      "theme.bar.shadow": "0px 0px 0px 0px #16161e",
      "theme.bar.transparent": true
    }
  '';
}
