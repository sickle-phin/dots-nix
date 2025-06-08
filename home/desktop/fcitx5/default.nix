{ pkgs, ... }:
{
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      fcitx5-with-addons = pkgs.kdePackages.fcitx5-with-addons;
      addons = [ pkgs.fcitx5-mozc-ut ]; # crash mozc_tool
      waylandFrontend = true;
    };
  };

  xdg.configFile = {
    "fcitx5/profile" = {
      source = ./profile;
      force = true;
    };
    "fcitx5/config" = {
      source = ./config;
      force = true;
    };
    "fcitx5/conf/classicui.conf" = {
      text = "Theme=catppuccin-mocha-pink";
    };
  };
  xdg.dataFile = {
    "fcitx5/themes/catppuccin-mocha-pink" = {
      source = ./catppuccin-mocha-pink;
    };
  };
}
