{
  inputs,
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
        showWorkspaceIndex = true;
        showWorkspaceApps = true;
        maxWorkspaceIcons = 4;
        clockDateFormat = "yyyy/MM/d";
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
            id = "clipboard";
            enabled = true;
          }
          {
            id = "battery";
            enabled = true;
          }
          {
            id = "systemTray";
            enabled = true;
          }
          {
            id = "controlCenterButton";
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
        fontScale = 1.05;
        fontFamily = "Mona Sans";
        monoFontFamily = "Moralerspace Neon HW";
        lockBeforeSuspend = true;
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
      session = {
        wallpaperPath = "${inputs.wallpaper}/wallpaper/sickle.jpg";
        perMonitorWallpaper = true;
        brightnessUserSetValues."backlight:intel_backlight" = 6;
        nightModeTemperature = 5000;
        nightModeHighTemperature = 6500;
      };
    };
  };

  systemd.user.services.dms.Service.Environment = [
    "QT_WAYLAND_FORCE_DPI=1.0"
    "LANG=en_US.UTF-8"
  ];
}
