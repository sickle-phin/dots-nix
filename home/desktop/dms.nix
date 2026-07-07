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
  inherit (lib.lists) optionals;
  inherit (lib.meta) getExe;
  jsonFormat = pkgs.formats.json { };
in
{
  imports = [
    inputs.dank-material-shell.homeModules.dank-material-shell
    inputs.dank-calendar.homeModules.dank-calendar
    inputs.dms-plugin-registry.homeModules.default
  ];

  home.packages = [
    pkgs.dsearch
    pkgs.tesseract
    pkgs.wl-clipboard
    pkgs.wl-screenrec
  ]
  ++ optionals (osConfig.programs.steam.enable && !osConfig.myOptions.isLaptop) [
    pkgs.linux-wallpaperengine
  ];

  programs = {
    dank-material-shell = {
      enable = true;
      systemd.enable = true;
      enableCalendarEvents = false;
      plugins = {
        calculator.enable = true;
        dankHooks.enable = true;
        emojiLauncher.enable = true;
        linuxWallpaperEngine.enable = osConfig.programs.steam.enable && !osConfig.myOptions.isLaptop;
        nixMonitor.enable = true;
        polyglot.enable = true;
        sathiAi.enable = true;
        wallpaperCarousel.enable = true;
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
    };

    dank-calendar = {
      enable = true;
      systemd.enable = true;
    };
  };

  xdg = {
    configFile = {
      "DankMaterialShell/default-settings.json".source = jsonFormat.generate "default-settings.json" {
        currentThemeName = "dynamic";
        matugenTargetMonitor = if osConfig.myOptions.isLaptop then "eDP-1" else "DP-1";
        popupTransparency = 0.9;
        dockTransparency = 0.9;
        cornerRadius = 10;
        animationSpeed = 2;
        syncComponentAnimationSpeeds = true;
        animationVariant = 0;
        motionEffect = 2;
        barElevationEnabled = false;
        blurredWallpaperLayer = false;
        blurWallpaperOnOverview = false;
        controlCenterShowNetworkIcon = true;
        controlCenterShowBluetoothIcon = true;
        controlCenterShowAudioIcon = true;
        controlCenterShowBrightnessIcon = false;
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
        maxWorkspaceIcons = 10;
        centeringMode = "geometric";
        clockDateFormat = "yyyy/M/dd";
        lockDateFormat = "dddd, MMMM d";
        sortAppsAlphabetically = true;
        appLauncherGridColumns = 6;
        spotlightSectionViewModes = {
          apps = "grid";
          files = "list";
          plugin_emojiLauncher = "tile";
          plugin_dms_settings_search = "list";
        };
        appDrawerSectionViewModes = {
          apps = "grid";
          files = "list";
          plugin_emojiLauncher = "tile";
          plugin_calculator = "list";
        };
        dankLauncherV2ShowFooter = false;
        useAutoLocation = true;
        iconTheme = "System Default";
        launcherLogoMode = "custom";
        launcherLogoCustomPath = "/etc/profiles/per-user/${username}/share/icons/Papirus/16x16/apps/distributor-logo-nixos.svg";
        launcherLogoColorOverride = "primary";
        launcherLogoSizeOffset = -1;
        monoFontFamily = "Moralerspace Neon HW";
        fontScale = 1.05;
        textRenderType = 0;
        textRenderQuality = 4;
        notepadShowLineNumbers = true;
        notepadDefaultMode = "popout";
        soundPluggedIn = false;
        acMonitorTimeout = 0;
        acLockTimeout = 600;
        acSuspendTimeout = 1200;
        acPostLockMonitorTimeout = 300;
        batteryMonitorTimeout = 0;
        batteryLockTimeout = 600;
        batterySuspendTimeout = 1200;
        batteryPostLockMonitorTimeout = 300;
        batteryChargeLimit = 80;
        batteryCriticalThreshold = 10;
        batteryNotifyCritical = true;
        batteryLowThreshold = 20;
        batteryNotifyLow = true;
        batteryNotificationType = 1;
        lockBeforeSuspend = true;
        fadeToLockEnabled = true;
        fadeToDpmsEnabled = true;
        launchPrefix = "LANG=ja_JP.UTF-8; uwsm-app --";
        gtkThemingEnabled = true;
        qtThemingEnabled = true;
        matugenTemplateNeovim = true;
        matugenTemplateNeovimSettings = {
          dark = {
            baseTheme = "catppuccin";
            harmony = 0.35;
          };
          light = {
            baseTheme = "catppuccin-latte";
            harmony = 0.35;
          };
        };
        notificationOverlayEnabled = true;
        modalDarkenBackground = true;
        lockScreenNotificationMode = 2;
        notificationTimeoutLow = 8000;
        notificationTimeoutNormal = 8000;
        notificationTimeoutCritical = 8000;
        notificationPopupPosition = 3;
        notificationAnimationSpeed = 2;
        notificationHistoryMaxCount = 1000;
        notificationRules = [
          {
            enabled = true;
            field = "body";
            pattern = "/dev/loop0 unmounted";
            matchType = "exact";
            action = "ignore";
            urgency = "default";
          }
          {
            enabled = true;
            field = "appName";
            pattern = ".uuctl-wrapped";
            matchType = "exact";
            action = "no_history";
            urgency = "default";
          }
          {
            enabled = true;
            field = "appName";
            pattern = "FUMonitor";
            matchType = "exact";
            action = "no_history";
            urgency = "default";
          }
          {
            enabled = true;
            field = "appName";
            pattern = "NixOS";
            matchType = "exact";
            action = "no_history";
            urgency = "default";
          }
          {
            enabled = true;
            field = "appName";
            pattern = "OCR";
            matchType = "exact";
            action = "no_history";
            urgency = "default";
          }
          {
            enabled = true;
            field = "summary";
            pattern = "Screenshot captured";
            matchType = "exact";
            action = "no_history";
            urgency = "default";
          }
          {
            enabled = true;
            field = "summary";
            pattern = "Low Battery";
            matchType = "exact";
            action = "no_history";
            urgency = "default";
          }
        ];
        notificationFocusedMonitor = true;
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
              if (osConfig.networking.hostName == "irukaha" || osConfig.networking.hostName == "labo") then
                [
                  {
                    name = "DP-1";
                  }
                ]
              else
                [ "all" ];
            showOnLastDisplay = false;
            leftWidgets = [
              "launcherButton"
              # "sathiAi"
              "polyglot"
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
            widgetPadding = 8;
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
            clickThrough = true;
          }
          {
            id = "sub";
            name = "Sub Bar";
            enabled = !osConfig.myOptions.isLaptop;
            position = 0;
            screenPreferences =
              if (osConfig.networking.hostName == "irukaha") then
                [
                  {
                    name = "HDMI-A-1";
                  }
                ]
              else if (osConfig.networking.hostName == "labo") then
                [
                  {
                    name = "DP-2";
                  }
                ]
              else
                [ "all" ];
            showOnLastDisplay = false;
            leftWidgets = [
              "launcherButton"
              # "sathiAi"
              "workspaceSwitcher"
            ];
            centerWidgets = [
              "clock"
              "notificationButton"
            ];
            rightWidgets = [
              "privacyIndicator"
              "battery"
              "controlCenterButton"
              "powerMenuButton"
            ];
            spacing = 2;
            widgetPadding = 8;
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
            clickThrough = true;
          }
        ];
        desktopWidgetInstances =
          let
            displayName =
              if osConfig.myOptions.isLaptop then
                "eDP-1"
              else if (osConfig.networking.hostName == "labo") then
                "DP-2"
              else
                "HDMI-A-1";
          in
          [
            {
              id = "dw_1768069523490_rqwxq8xsi";
              widgetType = "systemMonitor";
              name = "System Monitor";
              enabled = true;
              config = {
                displayPreferences = [
                  {
                    name = displayName;
                  }
                ];
              };
              positions = {
                ${displayName} = {
                  x = 1275;
                  y = 47;
                  width = 315;
                  height = 185;
                };
              };
            }
          ];
        clipboardRememberTypeFilter = true;
        configVersion = 11;
      };
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
        storeSizeCommand = [
          "sh"
          "-c"
          "du -sh /nix/store | cut -f1"
        ];
        updateInterval = 600;
      };
      "DankMaterialShell/default-plugin_settings.json".source =
        jsonFormat.generate "default-plugin_settings.json"
          {
            calculator = {
              enabled = true;
              calcEngine = "qalc";
            };
            dankHooks = {
              enabled = true;
              lightMode = "mode-changed-hook";
            };
            emojiLauncher = {
              enabled = true;
              trigger = ":";
            };
            linuxWallpaperEngine = {
              enabled = osConfig.programs.steam.enable && !osConfig.myOptions.isLaptop;
              monitorScenes.HDMI-A-1 = "2829534960";
              sceneSettings."2829534960" = {
                silent = true;
                fps = 60;
                scaling = "fill";
              };
              generateStaticWallpaper = true;
            };
            nixMonitor.enabled = true;
            polyglot = {
              enabled = true;
              sourceLanguage = "English";
              targetLanguage = "Japanese";
            };
            sathiAi = {
              enabled = false;
              maxMessageHistory = 100;
              windowWidth = 470;
              windowHeight = 800;
              aiModel = "gemini-2.5-flash";
            };
            wallpaperCarousel = {
              enabled = true;
              carouselMode = "infinite";
              borderWidth = 0;
              selectedScale = 100;
              expandSelected = "true";
              expandMultiplier = 200;
            };
          };
      "dankcal/ui-settings.json".source = jsonFormat.generate "ui-settings.json" {
        allDayReminderDaysBefore = 0;
        allDayReminderTime = "09:00";
        allDayReminders = false;
        closeBehavior = "minimize";
        colorSource = "auto";
        coreHoursEnabled = false;
        coreHoursEnd = 17;
        coreHoursStart = 9;
        customThemeFile = "";
        defaultEventDurationMinutes = 30;
        defaultReminderMinutes = 10;
        firstDayOfWeek = -1;
        lastView = "week";
        monthEventTitleLines = 1;
        presetTheme = "purple";
        reminderPersist = false;
        remindersEnabled = true;
        showTasks = true;
        showWeekNumbers = false;
        sidebarWidth = 240;
        snoozeMinutes = 5;
        syncIntervalMinutes = 30;
        themeMode = "auto";
        timeFormat = "auto";
        use24HourClock = false;
        weekEventTitleLines = 1;
      };
    };
    stateFile."DankMaterialShell/default-session.json".source =
      let
        backlight =
          if (osConfig.myOptions.gpu.vendor == "intel") then
            "intel_backlight"
          else if (osConfig.myOptions.gpu.vendor == "nvidia") then
            "nvidia_0"
          else
            "amdgpu_bl1";
      in
      jsonFormat.generate "default-session.json" {
        wallpaperPath = "${config.xdg.userDirs.pictures}/Wallpapers/sickle.jpg";
        monitorWallpapers = {
          eDP-1 = "${config.xdg.userDirs.pictures}/Wallpapers/sickle.jpg";
          DP-1 = "${config.xdg.userDirs.pictures}/Wallpapers/sickle.jpg";
          DP-2 = "${config.xdg.userDirs.pictures}/Wallpapers/virt_dolphin.jpg";
          HDMI-A-1 = "${config.xdg.userDirs.pictures}/Wallpapers/sickle.jpg";
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
          "easyeffects::Easy Effects"
          "nm-applet"
          "udiskie"
        ];
        trayItemOrder = [
          "Fcitx::キーボード - 英語 (US)"
        ];
        wallpaperTransition = "random";
        includedTransitions = [
          "wipe"
          "disc"
          "stripes"
          "pixelate"
          "portal"
        ];
        hiddenApps = [
          "rpg_rt.exe"
        ];
        hiddenOutputDeviceNames = [
          "easyeffects_sink"
        ];
      };
  };

  systemd.user.services.dms.Service = {
    Environment = [
      "LANG=en_US.UTF-8"
      "QT_IM_MODULES=fcitx"
      "TERMINAL=${getExe pkgs.ghostty}"
    ];
    EnvironmentFile = "/run/user/%U/uwsm/env_session.conf";
  };
}
