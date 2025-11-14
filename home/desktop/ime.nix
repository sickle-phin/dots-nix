{
  lib,
  osConfig,
  pkgs,
  ...
}:
let
  inherit (lib.modules) mkIf;
in
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
            # トリガーキーを押すたびに切り替える
            EnumerateWithTriggerKeys = "True";
            # 切り替え時は第1入力メソッドをスキップする
            EnumerateSkipFirst = "False";
            # 修飾キーのショートカットをトリガーするための時間制限（ミリ秒）
            ModifierOnlyKeyTimeout = 250;
          };
          "Hotkey/TriggerKeys"."0" = "Control+space";
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
            # デフォルトで有効にする
            ActiveByDefault = "False";
            # フォーカス時に状態をリセット
            resetStateWhenFocusIn = "No";
            # 入力状態を共有する
            ShareInputState = "No";
            # アプリケーションにプリエディットを表示する
            PreeditEnabledByDefault = "True";
            # 入力メソッドを切り替える際に入力メソッドの情報を表示する
            ShowInputMethodInformation = "True";
            # フォーカスを変更する際に入力メソッドの情報を表示する
            showInputMethodInformationWhenFocusIn = "False";
            # 入力メソッドの情報をコンパクトに表示する
            CompactInputMethodInformation = "True";
            # 第1入力メソッドの情報を表示する
            ShowFirstInputMethodInformation = "True";
            # デフォルトのページサイズ
            DefaultPageSize = 5;
            # XKB オプションより優先する
            OverrideXkbOption = "False";
            # Preload input method to be used by default
            PreloadInputMethod = "True";
            # パスワード欄に入力メソッドを許可する
            AllowInputMethodForPassword = "False";
            # パスワード入力時にプリエディットテキストを表示する
            ShowPreeditForPassword = "False";
            # ユーザーデータを保存する間隔（分）
            AutoSavePeriod = 30;
          };
        };
        inputMethod = {
          "Groups/0" = {
            Name = "Default";
            "Default Layout" = "us";
            DefaultIM = "mozc";
          };
          "Groups/0/Items/0" = {
            Name = "keyboard-us";
            Layout = "";
          };
          "Groups/0/Items/1" = {
            Name = "mozc";
            Layout = "";
          };
          "GroupOrder"."0" = "Default";
        };
        addons = {
          classicui.globalSection = {
            # 候補ウィンドウを縦にする
            "Vertical Candidate List" = "False";
            # マウスホイールを使用して前または次のページに移動する
            WheelForPaging = "True";
            # フォント
            Font = "Noto Sans CJK JP 10";
            # メニューフォント
            MenuFont = "Noto Sans CJK JP 10";
            # トレイフォント
            TrayFont = "Noto Sans CJK JP Bold 10";
            # トレイラベルのアウトライン色
            TrayOutlineColor = "#000000";
            # トレイラベルのテキスト色
            TrayTextColor = "#ffffff";
            # テキストアイコンを優先する
            PreferTextIcon = "False";
            # アイコンにレイアウト名を表示する
            ShowLayoutNameInIcon = "True";
            # 入力メソッドの言語を使用してテキストを表示する
            UseInputMethodLanguageToDisplayText = "True";
            # テーマ
            Theme = "catppuccin-latte-${osConfig.myOptions.catppuccin.accent.light}";
            # ダークテーマ
            DarkTheme = "catppuccin-mocha-${osConfig.myOptions.catppuccin.accent.dark}";
            # システムのライト/ダーク配色に従う
            UseDarkTheme = "True";
            # テーマとデスクトップでサポートされている場合は、システムのアクセントカラーに従う
            UseAccentColor = "True";
            # X11 で Per Screen DPI を使用する
            PerScreenDPI = "False";
            # フォント DPI を Wayland で強制する
            ForceWaylandDPI = 0;
            # Wayland で分数スケールを有効にする
            EnableFractionalScale = "True";
          };
        };
      };
      themes =
        let
          catppuccin = pkgs.catppuccin-fcitx5.override {
            withRoundedCorners = true;
          };
        in
        {
          "catppuccin-latte-${osConfig.myOptions.catppuccin.accent.light}" = {
            theme = builtins.readFile "${catppuccin}/share/fcitx5/themes/catppuccin-latte-${osConfig.myOptions.catppuccin.accent.light}/theme.conf";
            highlightImage = "${catppuccin}/share/fcitx5/themes/catppuccin-latte-${osConfig.myOptions.catppuccin.accent.light}/highlight.svg";
            panelImage = "${catppuccin}/share/fcitx5/themes/catppuccin-latte-${osConfig.myOptions.catppuccin.accent.light}/panel.svg";
          };
          "catppuccin-mocha-${osConfig.myOptions.catppuccin.accent.dark}" = {
            theme = builtins.readFile "${catppuccin}/share/fcitx5/themes/catppuccin-mocha-${osConfig.myOptions.catppuccin.accent.dark}/theme.conf";
            highlightImage = "${catppuccin}/share/fcitx5/themes/catppuccin-mocha-${osConfig.myOptions.catppuccin.accent.dark}/highlight.svg";
            panelImage = "${catppuccin}/share/fcitx5/themes/catppuccin-mocha-${osConfig.myOptions.catppuccin.accent.dark}/panel.svg";
          };
        };
    };
  };

  xdg = {
    configFile = {
      "autostart/org.fcitx.Fcitx5.desktop".text = "Hidden = true";
    };

    desktopEntries = {
      "fcitx5-configtool" = mkIf (!osConfig.myOptions.test.enable) {
        name = "Fcitx 5 Configuration";
        noDisplay = true;
      };
      "org.fcitx.Fcitx5" = {
        name = "Fcitx 5";
        noDisplay = true;
      };
      "org.fcitx.fcitx5-migrator" = {
        name = "Fcitx 5 Migration Wizard";
        noDisplay = true;
      };
      "mozc_tool" = {
        name = "mozc";
        icon = "mozc";
        noDisplay = true;
      };
    };
  };
}
