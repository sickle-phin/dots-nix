{ osConfig, pkgs, ... }:
let
  catppuccin-latte = pkgs.catppuccin-kvantum.override {
    accent = osConfig.myOptions.catppuccin.accent.light;
    variant = "latte";
  };
  catppuccin-mocha = pkgs.catppuccin-kvantum.override {
    accent = osConfig.myOptions.catppuccin.accent.dark;
    variant = "mocha";
  };
in
{
  qt = {
    enable = true;
    platformTheme.name = "qtct";
    style.name = "kvantum";
  };

  home.packages = builtins.attrValues {
    inherit catppuccin-latte;
    inherit catppuccin-mocha;
  };

  xdg.configFile = {
    "Kvantum/catppuccin-latte-${osConfig.myOptions.catppuccin.accent.light}".source =
      "${catppuccin-latte}/share/Kvantum/catppuccin-latte-${osConfig.myOptions.catppuccin.accent.light}";
    "Kvantum/catppuccin-mocha-${osConfig.myOptions.catppuccin.accent.dark}".source =
      "${catppuccin-mocha}/share/Kvantum/catppuccin-mocha-${osConfig.myOptions.catppuccin.accent.dark}";
    "hypr/application-style.conf".text = ''
      roundness = 2
      border_width = 2
    '';
  };

  specialisation = {
    dark.configuration.xdg.configFile = {
      "Kvantum/kvantum.kvconfig".text = ''
        [General]
        theme=catppuccin-mocha-${osConfig.myOptions.catppuccin.accent.dark}
      '';
      "qt5ct/qt5ct.conf".text = ''
        [Appearance]
        icon_theme=Papirus-Dark
        [Fonts]
        fixed="Noto Sans CJK JP,9,-1,5,50,0,0,0,0,0,Regular"
        general="Noto Sans CJK JP,9,-1,5,50,0,0,0,0,0,Regular"
      '';
      "qt6ct/qt6ct.conf".text = ''
        [Appearance]
        icon_theme=Papirus-Dark
        [Fonts]
        fixed="Noto Sans CJK JP,9,-1,5,400,0,0,0,0,0,0,0,0,0,0,1"
        general="Noto Sans CJK JP,9,-1,5,400,0,0,0,0,0,0,0,0,0,0,1"
      '';
    };
    light.configuration.xdg.configFile = {
      "Kvantum/kvantum.kvconfig".text = ''
        [General]
        theme=catppuccin-latte-${osConfig.myOptions.catppuccin.accent.light}
      '';
      "qt5ct/qt5ct.conf".text = ''
        [Appearance]
        icon_theme=Papirus-Light
        [Fonts]
        fixed="Noto Sans CJK JP,9,-1,5,50,0,0,0,0,0,Regular"
        general="Noto Sans CJK JP,9,-1,5,50,0,0,0,0,0,Regular"
      '';
      "qt6ct/qt6ct.conf".text = ''
        [Appearance]
        icon_theme=Papirus-Light
        [Fonts]
        fixed="Noto Sans CJK JP,9,-1,5,400,0,0,0,0,0,0,0,0,0,0,1"
        general="Noto Sans CJK JP,9,-1,5,400,0,0,0,0,0,0,0,0,0,0,1"
      '';
    };
  };
}
