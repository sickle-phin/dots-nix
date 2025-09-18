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
        include = "${config.xdg.cacheHome}/theme/fuzzel.ini";
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
}
