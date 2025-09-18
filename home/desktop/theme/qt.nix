{ pkgs, ... }:
let
  catppuccin-latte = pkgs.catppuccin-kvantum.override {
    accent = "pink";
    variant = "latte";
  };
  catppuccin-mocha = pkgs.catppuccin-kvantum.override {
    accent = "pink";
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
    "Kvantum/catppuccin-latte-pink".source = "${catppuccin-latte}/share/Kvantum/catppuccin-latte-pink";
    "Kvantum/catppuccin-mocha-pink".source = "${catppuccin-mocha}/share/Kvantum/catppuccin-mocha-pink";
  };

  specialisation =
    let
      qtct-fonts = ''
        [Fonts]
        fixed="Noto Sans CJK JP,l0,-1,5,400,0,0,0,0,0,0,0,0,0,0,1"
        general="Noto Sans CJK JP,10,-1,5,400,0,0,0,0,0,0,0,0,0,0,1"
      '';
    in
    {
      dark.configuration.xdg.configFile = {
        "Kvantum/kvantum.kvconfig".text = ''
          [General]
          theme=catppuccin-mocha-pink
        '';
        "qt5ct/qt5ct.conf".text = ''
          [Appearance]
          icon_theme=Papirus-Dark
        ''
        + qtct-fonts;
        "qt6ct/qt6ct.conf".text = ''
          [Appearance]
          icon_theme=Papirus-Dark
        ''
        + qtct-fonts;
      };
      light.configuration.xdg.configFile = {
        "Kvantum/kvantum.kvconfig".text = ''
          [General]
          theme=catppuccin-latte-pink
        '';
        "qt5ct/qt5ct.conf".text = ''
          [Appearance]
          icon_theme=Papirus-Light
        ''
        + qtct-fonts;
        "qt6ct/qt6ct.conf".text = ''
          [Appearance]
          icon_theme=Papirus-Light
        ''
        + qtct-fonts;
      };
    };
}
