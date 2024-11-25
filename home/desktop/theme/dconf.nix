{
  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
      "org/gnome/nm-applet" = {
        disable-disconnected-notifications = true;
        disable-connected-notifications = true;
        stop-wireless-networks-available = true;
      };
    };
  };
}
