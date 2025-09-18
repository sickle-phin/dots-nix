{
  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface".font-name = "Noto Sans CJK JP 11";
      "org/gnome/nm-applet" = {
        disable-disconnected-notifications = true;
        disable-connected-notifications = true;
        suppress-wireless-networks-available = true;
      };
    };
  };

  specialisation = {
    dark.configuration.dconf.settings."org/gnome/desktop/interface" = {
      gtk-theme = "catppuccin-mocha-pink-standard+normal";
      icon-theme = "Papirus-Dark";
    };
    light.configuration.dconf.settings."org/gnome/desktop/interface" = {
      gtk-theme = "catppuccin-latte-pink-standard+normal";
      icon-theme = "Papirus-Light";
    };
  };
}
