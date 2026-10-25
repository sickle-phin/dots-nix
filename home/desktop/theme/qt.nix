{
  config,
  pkgs,
  ...
}:
let
  jsonFormat = pkgs.formats.json { };
in
{
  qt = {
    enable = true;
    kvantum = {
      enable = true;
      settings.General.theme = "matugen";
    };
  };

  home = {
    packages = [
      pkgs.qtengine
      pkgs.kdePackages.qtstyleplugin-kvantum
      pkgs.libsForQt5.qtstyleplugin-kvantum
    ];
    sessionVariables = {
      QT_QPA_PLATFORM = "wayland;xcb";
      QT_QPA_PLATFORMTHEME = "qtengine";
      QT_SCALE_FACTOR = "1.2";
      QT_AUTO_SCREEN_SCALE_FACTOR = 1;
      QT_WAYLAND_DISABLE_WINDOWDECORATION = 1;
    };
  };

  xdg.configFile = {
    "hypr/application-style.conf".text = ''
      roundness = 2
      border_width = 2
    '';
    "qtengine/default-config.json".source = jsonFormat.generate "default-config.json" {
      theme = {
        colorScheme = "${config.xdg.dataHome}/color-schemes/DankMatugen.colors";
        iconTheme = "Papirus-Dark-Fcitx";
        style = "kvantum";
        font = {
          family = "Noto Sans CJK JP";
          size = 9;
          weight = -1;
        };
        fontFixed = {
          family = "Noto Sans Mono CJK JP";
          size = 9;
          weight = -1;
        };
      };
      misc = {
        menusHaveIcons = true;
        singleClickActivate = false;
        shortcutsForContextMenus = true;
      };
    };
  };
}
