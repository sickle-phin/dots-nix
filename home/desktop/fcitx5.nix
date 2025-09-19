{
  osConfig,
  pkgs,
  ...
}:
{
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      fcitx5-with-addons = pkgs.qt6Packages.fcitx5-with-addons.override {
        withConfigtool = osConfig.myOptions.test.enable;
      };
      addons = [ pkgs.fcitx5-mozc-ut ]; # crash mozc_tool
      waylandFrontend = true;
      settings = {
        globalOptions = {
          Metadata.ScaleWithDPI = true;
          Hotkey = {
            EnumerateWithTriggerKeys = true;
            EnumerateSkipFirst = false;
          };
          "Hotkey/TriggerKeys" = {
            "0" = "Control+space";
            "1" = "Zenkaku_Hankaku";
            "2" = "Hiragana_Katakana";
          };
          "Hotkey/AltTriggerKeys"."0" = "Shift_L";
          "Hotkey/EnumerateGroupForwardKeys"."0" = "Super+space";
          "Hotkey/EnumerateGroupBackwardKeys"."0" = "Shift+Super+space";
          "Hotkey/ActivateKeys"."0" = "Hangul_Hanja";
          "Hotkey/DeactivateKeys"."0" = "Hangul_Romaja";
          "Hotkey/PrevPage"."0" = "Up";
          "Hotkey/NextPage"."0" = "Down";
          "Hotkey/PrevCandidate"."0" = "Shift+Tab";
          "Hotkey/NextCandidate"."0" = "Tab";
          "Hotkey/TogglePreedit"."0" = "Control+Alt+P";
          Behavior = {
            ActiveByDefault = false;
            ShareInputState = "No";
            PreeditEnabledByDefault = true;
            ShowInputMethodInformation = true;
            showInputMethodInformationWhenFocusIn = false;
            CompactInputMethodInformation = true;
            ShowFirstInputMethodInformation = true;
            DefaultPageSize = 5;
            OverrideXkbOption = false;
            PreloadInputMethod = true;
            AllowInputMethodForPassword = false;
            ShowPreeditForPassword = false;
            AutoSavePeriod = 30;
          };
        };
        inputMethod = {
          "Groups/0" = {
            Name = "Default";
            "Default Layout" = "us";
            DefaultIM = "mozc";
          };
          "Groups/0/Items/0".Name = "keyboard-us";
          "Groups/0/Items/1".Name = "mozc";
          "GroupOrder"."0" = "Default";
        };
      };
      themes =
        let
          catppuccin = pkgs.catppuccin-fcitx5.override {
            withRoundedCorners = true;
          };
        in
        {
          catppuccin-latte-pink = {
            theme = builtins.readFile "${catppuccin}/share/fcitx5/themes/catppuccin-latte-pink/theme.conf";
            highlightImage = "${catppuccin}/share/fcitx5/themes/catppuccin-latte-pink/highlight.svg";
            panelImage = "${catppuccin}/share/fcitx5/themes/catppuccin-latte-pink/panel.svg";
          };
          catppuccin-mocha-pink = {
            theme = builtins.readFile "${catppuccin}/share/fcitx5/themes/catppuccin-mocha-pink/theme.conf";
            highlightImage = "${catppuccin}/share/fcitx5/themes/catppuccin-mocha-pink/highlight.svg";
            panelImage = "${catppuccin}/share/fcitx5/themes/catppuccin-mocha-pink/panel.svg";
          };
        };
    };
  };

  systemd.user.services.fcitx5-daemon.Service.Environment = "LANG=ja_JP.UTF-8";

  xdg = {
    desktopEntries = {
      "org.fcitx.Fcitx5" = {
        name = "Fcitx 5";
        noDisplay = true;
      };
      "org.fcitx.fcitx5-migrator" = {
        name = "Fcitx 5 Migration Wizard";
        noDisplay = true;
      };
      "mozc config dialog" = {
        name = "mozc config dialog";
        genericName = "mozc config dialog";
        icon = "mozc";
        exec = "${pkgs.mozc}/lib/mozc/mozc_tool --mode=config_dialog";
        type = "Application";
        categories = [ "Settings" ];
      };
      "mozc dictionary tool" = {
        name = "mozc dictionary tool";
        genericName = "mozc user dictionary tool";
        icon = "mozc";
        exec = "${pkgs.mozc}/lib/mozc/mozc_tool --mode=dictionary_tool";
        type = "Application";
        categories = [ "Settings" ];
      };
    };
  };

  specialisation = {
    dark.configuration.i18n.inputMethod.fcitx5.settings.addons.classicui.globalSection.Theme =
      "catppuccin-mocha-pink";
    light.configuration.i18n.inputMethod.fcitx5.settings.addons.classicui.globalSection.Theme =
      "catppuccin-latte-pink";
  };
}
