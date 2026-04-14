{ pkgs, ... }:
{
  home.packages = builtins.attrValues {
    inherit (pkgs)
      papirus-icon-theme
      ;
  };

  xdg.dataFile = {
    "icons/Papirus-Dark-Fcitx/index.theme".text = ''
      [Icon Theme]
      Name=Papirus-Dark-Fcitx
      Inherits=Papirus-Dark,breeze-dark,hicolor

      Directories=16x16/devices

      [16x16/devices]
      Context=Devices
      Size=16
      Type=Fixed
    '';
    "icons/Papirus-Dark-Fcitx/16x16/devices/input-keyboard-symbolic.svg".source =
      "${pkgs.papirus-icon-theme}/share/icons/Papirus-Dark/16x16/devices/input-keyboard.svg";

    "icons/Papirus-Dark/16x16/panel/hazkey.svg".source =
      "${pkgs.papirus-icon-theme}/share/icons/Papirus-Dark/16x16/panel/fcitx-mozc-hiragana.svg";
    "icons/Papirus-Dark/16x16/panel/fcitx_mozc_alpha_full.svg".source =
      "${pkgs.papirus-icon-theme}/share/icons/Papirus-Dark/16x16/panel/fcitx-mozc-alpha-full.svg";
    "icons/Papirus-Dark/16x16/panel/fcitx_mozc_alpha_half.svg".source =
      "${pkgs.papirus-icon-theme}/share/icons/Papirus-Dark/16x16/panel/fcitx-mozc-alpha-half.svg";
    "icons/Papirus-Dark/16x16/panel/fcitx_mozc_dictionary.svg".source =
      "${pkgs.papirus-icon-theme}/share/icons/Papirus-Dark/16x16/panel/fcitx-mozc-dictionary.svg";
    "icons/Papirus-Dark/16x16/panel/fcitx_mozc_direct.svg".source =
      "${pkgs.papirus-icon-theme}/share/icons/Papirus-Dark/16x16/panel/fcitx-mozc-direct.svg";
    "icons/Papirus-Dark/16x16/panel/fcitx_mozc_hiragana.svg".source =
      "${pkgs.papirus-icon-theme}/share/icons/Papirus-Dark/16x16/panel/fcitx-mozc-hiragana.svg";
    "icons/Papirus-Dark/16x16/panel/fcitx_mozc_katakana_full.svg".source =
      "${pkgs.papirus-icon-theme}/share/icons/Papirus-Dark/16x16/panel/fcitx-mozc-katakana-full.svg";
    "icons/Papirus-Dark/16x16/panel/fcitx_mozc_katakana_half.svg".source =
      "${pkgs.papirus-icon-theme}/share/icons/Papirus-Dark/16x16/panel/fcitx-mozc-katakana-half.svg";
    "icons/Papirus-Dark/16x16/panel/fcitx_mozc_properties.svg".source =
      "${pkgs.papirus-icon-theme}/share/icons/Papirus-Dark/16x16/panel/fcitx-mozc-properties.svg";
    "icons/Papirus-Dark/16x16/panel/fcitx_mozc_tool.svg".source =
      "${pkgs.papirus-icon-theme}/share/icons/Papirus-Dark/16x16/panel/fcitx-mozc-tool.svg";

    "icons/Papirus-Light/16x16/panel/hazkey.svg".source =
      "${pkgs.papirus-icon-theme}/share/icons/Papirus-Light/16x16/panel/fcitx-mozc-hiragana.svg";
    "icons/Papirus-Light/16x16/panel/fcitx_mozc_alpha_full.svg".source =
      "${pkgs.papirus-icon-theme}/share/icons/Papirus-Light/16x16/panel/fcitx-mozc-alpha-full.svg";
    "icons/Papirus-Light/16x16/panel/fcitx_mozc_alpha_half.svg".source =
      "${pkgs.papirus-icon-theme}/share/icons/Papirus-Light/16x16/panel/fcitx-mozc-alpha-half.svg";
    "icons/Papirus-Light/16x16/panel/fcitx_mozc_dictionary.svg".source =
      "${pkgs.papirus-icon-theme}/share/icons/Papirus-Light/16x16/panel/fcitx-mozc-dictionary.svg";
    "icons/Papirus-Light/16x16/panel/fcitx_mozc_direct.svg".source =
      "${pkgs.papirus-icon-theme}/share/icons/Papirus-Light/16x16/panel/fcitx-mozc-direct.svg";
    "icons/Papirus-Light/16x16/panel/fcitx_mozc_hiragana.svg".source =
      "${pkgs.papirus-icon-theme}/share/icons/Papirus-Light/16x16/panel/fcitx-mozc-hiragana.svg";
    "icons/Papirus-Light/16x16/panel/fcitx_mozc_katakana_full.svg".source =
      "${pkgs.papirus-icon-theme}/share/icons/Papirus-Light/16x16/panel/fcitx-mozc-katakana-full.svg";
    "icons/Papirus-Light/16x16/panel/fcitx_mozc_katakana_half.svg".source =
      "${pkgs.papirus-icon-theme}/share/icons/Papirus-Light/16x16/panel/fcitx-mozc-katakana-half.svg";
    "icons/Papirus-Light/16x16/panel/fcitx_mozc_properties.svg".source =
      "${pkgs.papirus-icon-theme}/share/icons/Papirus-Light/16x16/panel/fcitx-mozc-properties.svg";
    "icons/Papirus-Light/16x16/panel/fcitx_mozc_tool.svg".source =
      "${pkgs.papirus-icon-theme}/share/icons/Papirus-Light/16x16/panel/fcitx-mozc-tool.svg";
  };
}
