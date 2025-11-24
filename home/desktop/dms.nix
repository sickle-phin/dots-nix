{
  inputs,
  lib,
  osConfig,
  pkgs,
  username,
  ...
}:
let
  inherit (lib.modules) mkIf;
in
{
  imports = [
    inputs.dankMaterialShell.homeModules.dankMaterialShell.default
  ];

  programs.dankMaterialShell = {
    enable = true;
    systemd.enable = true;
    quickshell.package = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default;
    plugins = {
      dankBatteryAlerts.src = "${inputs.dms-plugins}/DankBatteryAlerts";
      dankHooks.src = "${inputs.dms-plugins}/DankHooks";
      dankCalculator.src = "${inputs.dankCalculator}";
      dms-emoji-launcher.src = "${inputs.dms-emoji-launcher}";
      dms-wallpaperengine.src = "${inputs.dms-wallpaperengine}";
    };
    default = {
      settings = {
        currentThemeName = "dynamic";
        dankBarTransparency = 0;
        dankBarWidgetTransparency = 0.85;
        matugenTargetMonitor = mkIf (!osConfig.myOptions.isLaptop) "DP-1";
        popupTransparency = 0.9;
        dockTransparency = 0.9;
        cornerRadius = 10;
        animationSpeed = 2;
        blurredWallpaperLayer = false;
        blurWallpaperOnOverview = false;
        controlCenterWidgets = [
          {
            id = "wifi";
            enabled = true;
            width = 50;
          }
          {
            id = "bluetooth";
            enabled = true;
            width = 50;
          }
          {
            id = "audioOutput";
            enabled = true;
            width = 50;
          }
          {
            id = "volumeSlider";
            enabled = true;
            width = 50;
          }
          {
            id = "audioInput";
            enabled = true;
            width = 50;
          }
          {
            id = "inputVolumeSlider";
            enabled = true;
            width = 50;
          }
          {
            id = "colorPicker";
            enabled = true;
            width = 50;
          }
          {
            id = "brightnessSlider";
            enabled = true;
            width = 50;
          }
          {
            id = "darkMode";
            enabled = true;
            width = 25;
          }
          {
            id = "nightMode";
            enabled = true;
            width = 25;
          }
          {
            id = "idleInhibitor";
            enabled = true;
            width = 25;
          }
          {
            id = "builtin_cups";
            enabled = true;
            width = 25;
          }
        ];
        showWorkspaceIndex = true;
        showWorkspaceApps = true;
        maxWorkspaceIcons = 4;
        clockDateFormat = "yyyy/MM/d";
        lockDateFormat = "dddd, MMMM d";
        dankBarLeftWidgets = [
          {
            id = "launcherButton";
            enabled = true;
          }
          {
            id = "workspaceSwitcher";
            enabled = true;
          }
          {
            id = "music";
            enabled = true;
          }
        ];
        dankBarCenterWidgets = [
          {
            id = "spacer";
            enabled = true;
            size = 20;
          }
          {
            id = "clock";
            enabled = true;
          }
          {
            id = "weather";
            enabled = true;
          }
        ];

        dankBarRightWidgets = [
          {
            id = "privacyIndicator";
            enabled = true;
          }
          {
            id = "battery";
            enabled = true;
          }
          {
            id = "controlCenterButton";
            enabled = true;
          }
          {
            id = "systemTray";
            enabled = true;
          }
          {
            id = "notificationButton";
            enabled = true;
          }
        ];

        appLauncherViewMode = "grid";
        spotlightModalViewMode = "grid";
        sortAppsAlphabetically = true;
        appLauncherGridColumns = 5;
        useAutoLocation = true;
        iconTheme = "System Default";
        launcherLogoMode = "custom";
        launcherLogoCustomPath = "/etc/profiles/per-user/${username}/share/icons/Papirus/128x128/apps/distributor-logo-nixos.svg";
        launcherLogoColorOverride = "primary";
        launcherLogoSizeOffset = 2;
        fontScale = 1.05;
        dankBarFontScale = 1.05;
        monoFontFamily = "Moralerspace Neon HW";
        acMonitorTimeout = 900;
        acLockTimeout = 600;
        acSuspendTimeout = 1200;
        batteryMonitorTimeout = 900;
        batteryLockTimeout = 600;
        batterySuspendTimeout = 1200;
        lockBeforeSuspend = true;
        preventIdleForMedia = true;
        launchPrefix = "LANG=ja_JP.UTF-8; uwsm-app --";
        gtkThemingEnabled = true;
        qtThemingEnabled = true;
        notificationOverlayEnabled = true;
        dankBarSpacing = 2;
        dankBarBottomGap = -7;
        dankBarInnerPadding = 6;
        modalDarkenBackground = true;
        notificationTimeoutLow = 8000;
        notificationTimeoutNormal = 8000;
        notificationTimeoutCritical = 8000;
        notificationPopupPosition = 3;
        osdAlwaysShowValue = true;
        powerActionConfirm = false;
        powerMenuActions = [
          "lock"
          "suspend"
          "logout"
          "reboot"
          "poweroff"
        ];
        powerMenuDefaultAction = "lock";
        customPowerActionLogout = "uwsm stop";
      };
      session =
        let
          backlight =
            if (osConfig.myOptions.gpu.vendor == "intel") then
              "intel_backlight"
            else if (osConfig.myOptions.gpu.vendor == "nvidia") then
              "nvidia_0"
            else
              "amdgpu_bl1";
        in
        {
          wallpaperPath = "${inputs.wallpaper}/wallpaper/sickle.jpg";
          monitorWallpapers = {
            eDP-1 = "${inputs.wallpaper}/wallpaper/sickle.jpg";
            DP-1 = "${inputs.wallpaper}/wallpaper/sickle.jpg";
            HDMI-A-1 = "${inputs.wallpaper}/wallpaper/sickle.jpg";
          };
          perMonitorWallpaper = true;
          brightnessExponentialDevices."backlight:${backlight}" = true;
          nightModeTemperature = 5000;
          nightModeHighTemperature = 6500;
          hiddenTrayIds = [
            "blueman"
            "nm-applet"
            "udiskie"
          ];
          wallpaperTransition = "random";
          includedTransitions = [
            "wipe"
            "disc"
            "stripes"
            "pixelate"
            "portal"
          ];
        };
    };
  };

  xdg.configFile."DankMaterialShell/plugin_settings.json".text = ''
    {
      "dankBatteryAlerts": {
        "enabled": true
      },
      "dankHooks": {
        "enabled": true,
        "wallpaperPath": "wallpaper-changed-hook",
        "monitorWallpaper": "wallpaper-changed-hook",
        "lightMode": "mode-changed-hook"
      },
      "calculator": {
        "enabled": true
      },
      "emojiLauncher": {
        "enabled": true
      },
      "linuxWallpaperEngine": {
        "enabled": ${if (osConfig.networking.hostName == "irukaha") then "true" else "false"},
        "monitorScenes": {
          "HDMI-A-1": "2829534960"
        },
        "sceneSettings": {
          "2829534960": {
            "silent": false,
            "fps": 30,
            "scaling": "fill"
          }
        }
      }
    }
  '';

  systemd.user.services.dms.Service.Environment = [
    "LANG=en_US.UTF-8"
  ];
}
