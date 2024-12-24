{ lib, pkgs, ... }:
let
  inherit (lib.modules) mkDefault;
in
{
  time.timeZone = mkDefault "Asia/Tokyo";

  i18n = {
    supportedLocales = [
      "C.UTF-8/UTF-8"
      "en_US.UTF-8/UTF-8"
      "ja_JP.UTF-8/UTF-8"
    ];
    defaultLocale = mkDefault "en_US.UTF-8";
    extraLocaleSettings = mkDefault {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };

    inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5 = {
        addons = [ pkgs.fcitx5-mozc-ut ]; # crash mozc_tool
        waylandFrontend = true;
      };
    };
  };

  catppuccin.fcitx5.enable = true;
}
