{ pkgs, ... }:
{
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5 = {
      addons = [
        pkgs.fcitx5-mozc
        pkgs.fcitx5-gtk
      ];
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
    "fcitx5/conf/classicui.conf".text = "Theme=catppuccin-mocha-mauve";
  };

  xdg.dataFile = {
    "fcitx5/themes/catppuccin-mocha-mauve" =
      let
        fcitx5 = pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "fcitx5";
          rev = "3471b918d4b5aab2d3c3dd9f2c3b9c18fb470e8e";
          sha256 = "sha256-1IqFVTEY6z8yNjpi5C+wahMN1kpt0OJATy5echjPXmc=";
        };
      in
      {
        source = "${fcitx5}/src/catppuccin-mocha-mauve";
      };
  };
}
