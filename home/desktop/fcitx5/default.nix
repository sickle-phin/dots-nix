{ pkgs, ... }:
{
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5 = {
      addons = [
        pkgs.fcitx5-mozc
        pkgs.fcitx5-gtk
      ];
      catppuccin.enable = true;
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
  };
}
