{ osConfig, pkgs, ... }:
{
  home.packages =
    let
      catppuccin-latte = pkgs.catppuccin-gtk.override {
        accents = [ osConfig.myOptions.catppuccin.accent.light ];
        size = "standard";
        tweaks = [ "normal" ];
        variant = "latte";
      };
      catppuccin-mocha = pkgs.catppuccin-gtk.override {
        accents = [ osConfig.myOptions.catppuccin.accent.dark ];
        size = "standard";
        tweaks = [ "normal" ];
        variant = "mocha";
      };
    in
    builtins.attrValues {
      inherit catppuccin-latte;
      inherit catppuccin-mocha;
      inherit (pkgs)
        papirus-icon-theme
        ;
    };

  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        font-name = "Noto Sans CJK JP 11";
        cursor-size = 34;
      };
      "org/gnome/nm-applet" = {
        disable-disconnected-notifications = true;
        disable-connected-notifications = true;
        suppress-wireless-networks-available = true;
      };
    };
  };

  specialisation = {
    dark.configuration.dconf.settings."org/gnome/desktop/interface" = {
      cursor-theme = "catppuccin-mocha-dark-cursors";
      icon-theme = "Papirus-Dark";
    };
    light.configuration.dconf.settings."org/gnome/desktop/interface" = {
      cursor-theme = "catppuccin-latte-light-cursors";
      icon-theme = "Papirus-Light";
    };
  };
}
