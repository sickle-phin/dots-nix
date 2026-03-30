{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib.modules) mkDefault;
  jsonFormat = pkgs.formats.json { };

  qtEngine = theme: {
    theme = {
      colorScheme = "${config.xdg.configHome}/qt6ct/colors/matugen.conf";
      iconTheme = "Papirus-${theme}";
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
    "qtengine/config.json".source = mkDefault (
      jsonFormat.generate "config.json" (qtEngine "Dark-Fcitx")
    );
  };

  specialisation = {
    dark.configuration.xdg.configFile."qtengine/config.json".source =
      jsonFormat.generate "config.json" (qtEngine "Dark-Fcitx");

    light.configuration.xdg.configFile."qtengine/config.json".source =
      jsonFormat.generate "config.json" (qtEngine "Light");
  };
}
