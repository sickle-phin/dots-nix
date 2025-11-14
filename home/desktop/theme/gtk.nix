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
        adw-gtk3
        ;
    };

  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        gtk-theme = "adw-gtk3";
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

  xdg.configFile =
    let
      extraCss = "@import url(\"dank-colors.css\");";
    in
    {
      "gtk-3.0/gtk.css".text = extraCss;
      "gtk-4.0/gtk.css".text = extraCss;
    };
}
