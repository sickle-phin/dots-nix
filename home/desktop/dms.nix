{
  config,
  inputs,
  lib,
  osConfig,
  pkgs,
  username,
  ...
}:
let
  inherit (lib.modules) mkIf;
  jsonFormat = pkgs.formats.json { };
in
{
  imports = [
    inputs.dank-material-shell.homeModules.dank-material-shell
  ];

  programs = {
    dank-material-shell = {
      enable = true;
      systemd.enable = true;
      plugins = {
        calculator = {
          src = "${inputs.dankCalculator}";
          settings.enabled = true;
        };
        dankBatteryAlerts = {
          src = "${inputs.dms-plugins}/DankBatteryAlerts";
          settings.enabled = true;
        };
        dankHooks = {
          src = "${inputs.dms-plugins}/DankHooks";
          settings = {
            enabled = true;
            lightMode = "mode-changed-hook";
          };
        };
        emojiLauncher = {
          src = "${inputs.dms-emoji-launcher}";
          settings.enabled = true;
        };
        linuxWallpaperEngine = {
          src = "${inputs.dms-wallpaperengine}";
          settings = {
            enabled = osConfig.networking.hostName == "irukaha";
            monitorScenes.HDMI-A-1 = "2829534960";
            sceneSettings."2829534960" = {
              silent = true;
              fps = 30;
              scaling = "fill";
            };
            generateStaticWallpaper = true;
          };
        };
        nixMonitor = {
          src = "${inputs.nix-monitor}";
          settings.enabled = true;
        };
      };
      settings = {
        currentThemeName = "dynamic";
        matugenTargetMonitor = mkIf (!osConfig.myOptions.isLaptop) "DP-1";
        popupTransparency = 0.9;
        dockTransparency = 0.9;
        cornerRadius = 10;
        animationSpeed = 2;
        blurredWallpaperLayer = false;
        blurWallpaperOnOverview = false;
        controlCenterShowNetworkIcon = true;
        controlCenterShowBluetoothIcon = true;
        controlCenterShowAudioIcon = true;
        controlCenterShowBrightnessIcon = true;
        controlCenterShowMicIcon = true;
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
        showWorkspaceName = true;
        showWorkspaceApps = true;
        maxWorkspaceIcons = 4;
        centeringMode = "geometric";
        clockDateFormat = "yyyy/M/d";
        lockDateFormat = "dddd, MMMM d";
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
        monoFontFamily = "Moralerspace Neon HW";
        fontScale = 1.05;
        acMonitorTimeout = 900;
        acLockTimeout = 600;
        acSuspendTimeout = 1200;
        batteryMonitorTimeout = 900;
        batteryLockTimeout = 600;
        batterySuspendTimeout = 1200;
        lockBeforeSuspend = true;
        fadeToLockEnabled = true;
        fadeToDpmsEnabled = true;
        launchPrefix = "LANG=ja_JP.UTF-8; uwsm-app --";
        gtkThemingEnabled = true;
        qtThemingEnabled = true;
        notificationOverlayEnabled = true;
        modalDarkenBackground = true;
        lockScreenNotificationMode = 2;
        notificationTimeoutLow = 8000;
        notificationTimeoutNormal = 8000;
        notificationTimeoutCritical = 8000;
        notificationPopupPosition = 3;
        notificationHistoryMaxCount = 1000;
        osdAlwaysShowValue = true;
        osdPowerProfileEnabled = true;
        powerActionConfirm = true;
        powerMenuActions = [
          "lock"
          "suspend"
          "logout"
          "reboot"
          "poweroff"
        ];
        powerMenuDefaultAction = "lock";
        customPowerActionLogout = "uwsm stop";
        barConfigs = [
          {
            id = "default";
            name = "Main Bar";
            enabled = true;
            position = 0;
            screenPreferences =
              if (osConfig.networking.hostName == "labo") then
                [
                  {
                    name = "DP-1";
                    model = "DELL U2720QM";
                  }
                ]
              else
                [ "all" ];
            showOnLastDisplay = false;
            leftWidgets = [
              "launcherButton"
              "workspaceSwitcher"
              "music"
            ];
            centerWidgets = [
              "clock"
              "notificationButton"
            ];
            rightWidgets = [
              "privacyIndicator"
              "systemTray"
              "battery"
              "controlCenterButton"
              "nixMonitor"
              "powerMenuButton"
            ];
            spacing = 2;
            innerPadding = 6;
            bottomGap = -7;
            transparency = 0;
            widgetTransparency = "0.85";
            squareCorners = false;
            noBackground = false;
            gothCornersEnabled = false;
            gothCornerRadiusOverride = false;
            gothCornerRadiusValue = 12;
            borderEnabled = false;
            borderColor = "surfaceText";
            borderOpacity = 1;
            borderThickness = 1;
            fontScale = 1.05;
            autoHide = false;
            autoHideDelay = 250;
            openOnOverview = false;
            visible = true;
            popupGapsAuto = true;
            popupGapsManual = 4;
          }
        ];
      };
      clipboardSettings = {
        maxHistory = 100;
        maxEntrySize = 5242880;
        autoClearDays = 1;
        clearAtStartup = false;
        disabled = false;
        disableHistory = false;
        disablePersist = false;
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
          wallpaperPath = "${config.xdg.userDirs.pictures}/Wallpapers/sickle.jpg";
          monitorWallpapers = {
            eDP-1 = "${config.xdg.userDirs.pictures}/Wallpapers/sickle.jpg";
            DP-1 = "${config.xdg.userDirs.pictures}/Wallpapers/sickle.jpg";
            HDMI-A-1 =
              if (osConfig.networking.hostName == "labo") then
                "${config.xdg.userDirs.pictures}/Wallpapers/virt_dolphin.jpg"
              else
                "${config.xdg.userDirs.pictures}/Wallpapers/sickle.jpg";
          };
          perMonitorWallpaper = true;
          brightnessExponentialDevices."backlight:${backlight}" = true;
          nightModeEnabled = osConfig.myOptions.isLaptop;
          nightModeTemperature = 5500;
          nightModeHighTemperature = 6500;
          nightModeAutoEnabled = true;
          nightModeAutoMode = "location";
          nightModeUseIPLocation = true;
          hiddenTrayIds = [
            "easyeffects"
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
      managePluginSettings = true;
    };
  };

  xdg.configFile = {
    "DankMaterialShell/plugins/NixMonitor/config.json".source = jsonFormat.generate "config.json" {
      generationsCommand = [
        "sh"
        "-c"
        "echo $(( $(ls /nix/var/nix/profiles | wc -l) - 3 ))"
      ];
      rebuildCommand = [
        "sh"
        "-c"
        "nh os switch -H \"${osConfig.networking.hostName}\""
      ];
      updateInterval = 600;
    };
  };

  systemd.user.services.dms.Service.Environment = [
    "LANG=en_US.UTF-8"
    "QT_IM_MODULES=fcitx"
    "TERMINAL=ghostty"
  ];
}
