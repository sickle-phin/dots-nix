{ config, pkgs, ... }:

{
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-mozc
      fcitx5-gtk
      # libsForQt5.fcitx5-qt
      fcitx5-configtool
    ];
  };

  xdg.configFile = {
    "fcitx5/profile" = {
      source = ./profile;
      force = true;
    };
  };

  xdg.configFile = {
    "fcitx5/config" = {
      source = ./config;
      force = true;
    };
  };
}
