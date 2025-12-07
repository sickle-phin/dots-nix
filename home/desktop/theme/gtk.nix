{ pkgs, ... }:
{
  home = {
    packages = builtins.attrValues {
      inherit (pkgs)
        adw-gtk3
        ;
    };

    sessionVariables.GDK_BACKEND = "wayland,x11";
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
