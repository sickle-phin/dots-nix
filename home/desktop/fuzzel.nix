{
  config,
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
        font = "Inter Variable:size=10";
        use-bold = true;
        icon-theme = "Papirus";
        placeholder = "Search...";
        prompt = "\">>  \"";
        match-counter = true;
        terminal = "${getExe pkgs.ghostty} -e";
        launch-prefix = "env LANG=ja_JP.UTF-8 uwsm-app -- ";
        lines = 10;
        width = 60;
        tabs = 4;
        image-size-ratio = "0.4";
        line-height = 25;
        layer = "overlay";
        include = "${config.xdg.cacheHome}/DankMaterialShell/fuzzel-theme.ini";
      };
      border = {
        radius = 17;
        width = 3;
      };
    };
  };
}
