{
  inputs,
  osConfig,
  pkgs,
  ...
}:
{
  imports = [
    inputs.dankMaterialShell.homeModules.dankMaterialShell.default
  ];

  programs.dankMaterialShell = {
    enable = true;
    systemd.enable = true;
    plugins = {
      dankBatteryAlerts.src = "${inputs.dms-plugins}/DankBatteryAlerts";
      dankHooks.src = "${inputs.dms-plugins}/DankHooks";
    };
    default = {
      settings = {
        currentThemeName = "dynamic";
        dankBarTransparency = 0;
        dankBarWidgetTransparency = 0.85;
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
            id = "clipboard";
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
        spotlightModalViewMode = "list";
        sortAppsAlphabetically = true;
        useAutoLocation = true;
        iconTheme = "System Default";
        launcherLogoMode = "custom";
        launcherLogoCustomPath = "${pkgs.papirus-icon-theme}/share/icons/Papirus/128x128/apps/distributor-logo-nixos.svg";
        launcherLogoSizeOffset = 4;
        fontScale = 1.05;
        fontFamily = "Inter";
        monoFontFamily = "Moralerspace Neon HW";
        acMonitorTimeout = 900;
        acLockTimeout = 600;
        acSuspendTimeout = 1200;
        batteryMonitorTimeout = 900;
        batteryLockTimeout = 600;
        batterySuspendTimeout = 1200;
        lockBeforeSuspend = true;
        preventIdleForMedia = true;
        launchPrefix = "uwsm-app --";
        gtkThemingEnabled = true;
        qtThemingEnabled = true;
        notificationOverlayEnabled = true;
        dankBarSpacing = 1;
        dankBarBottomGap = -6;
        dankBarInnerPadding = 9;
        modalDarkenBackground = true;
        notificationTimeoutLow = 8000;
        notificationTimeoutNormal = 8000;
        notificationTimeoutCritical = 8000;
        notificationPopupPosition = 3;
        osdAlwaysShowValue = true;
        powerActionConfirm = false;
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
          perMonitorWallpaper = true;
          brightnessExponentialDevices."backlight:${backlight}" = true;
          nightModeTemperature = 5000;
          nightModeHighTemperature = 6500;
          hiddenTrayIds = [
            "nm-applet"
          ];
          wallpaperTransition = "random";
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
        "lightMode": "toggle-theme"
      }
    }
  '';

  systemd.user.services.dms.Service.Environment = [
    "QT_WAYLAND_FORCE_DPI=1.0"
    "LANG=en_US.UTF-8"
  ];
}
