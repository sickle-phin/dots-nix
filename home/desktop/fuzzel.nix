{
  lib,
  pkgs,
  ...
}:
let
  inherit (lib.meta) getExe;
in
{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        font = "Mona Sans:size=10";
        use-bold = true;
        placeholder = "Search...";
        prompt = "\">>  \"";
        match-counter = true;
        terminal = "${getExe pkgs.ghostty} -e";
        launch-prefix = "env LANG=ja_JP.UTF-8 uwsm-app -- ";
        lines = 10;
        width = 40;
        tabs = 4;
        image-size-ratio = "0.4";
        line-height = 25;
        layer = "overlay";
      };
      border = {
        radius = 17;
        width = 3;
      };
    };
  };

  specialisation = {
    dark.configuration.programs.fuzzel.settings.main = {
      include = "${pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/catppuccin/fuzzel/refs/heads/main/themes/catppuccin-mocha/pink.ini";
        sha256 = "sha256-tiaY5FBVXMx26XPfCKNf5+FBKABNfPEXRnNJGFet9z4=";
      }}";
      icon-theme = "Papirus-Dark";
    };
    light.configuration.programs.fuzzel.settings.main = {
      include = "${pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/catppuccin/fuzzel/refs/heads/main/themes/catppuccin-latte/pink.ini";
        sha256 = "sha256-0Ozg7GKBsw4Kb2IbcbufKMePBBTL0yXMwcX0u47bhnk=";
      }}";
      icon-theme = "Papirus-Light";
    };
  };
}
