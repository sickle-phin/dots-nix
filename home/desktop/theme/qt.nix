{ config, lib, ... }:
let
  inherit (lib.modules) mkDefault;

  qt5ct = theme: ''
    [Appearance]
    color_scheme_path=${config.xdg.configHome}/qt5ct/colors/matugen.conf
    custom_palette=true
    icon_theme=Papirus-${theme}
    [Fonts]
    fixed="Noto Sans CJK JP,9,-1,5,50,0,0,0,0,0,Regular"
    general="Noto Sans CJK JP,9,-1,5,50,0,0,0,0,0,Regular"
  '';
  qt6ct = theme: ''
    [Appearance]
    color_scheme_path=${config.xdg.configHome}/qt6ct/colors/matugen.conf
    custom_palette=true
    icon_theme=Papirus-${theme}
    [Fonts]
    fixed="Noto Sans CJK JP,9,-1,5,400,0,0,0,0,0,0,0,0,0,0,1"
    general="Noto Sans CJK JP,9,-1,5,400,0,0,0,0,0,0,0,0,0,0,1"
  '';
in
{
  qt = {
    enable = true;
    platformTheme.name = "qtct";
  };

  home = {
    sessionVariables = {
      QT_QPA_PLATFORM = "wayland;xcb";
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
    "qt5ct/qt5ct.conf".text = mkDefault (qt5ct "Dark");
    "qt6ct/qt6ct.conf".text = mkDefault (qt6ct "Dark");
  };

  specialisation = {
    dark.configuration.xdg.configFile = {
      "qt5ct/qt5ct.conf".text = qt5ct "Dark";
      "qt6ct/qt6ct.conf".text = qt6ct "Dark";
    };
    light.configuration.xdg.configFile = {
      "qt5ct/qt5ct.conf".text = qt5ct "Light";
      "qt6ct/qt6ct.conf".text = qt6ct "Light";
    };
  };
}
