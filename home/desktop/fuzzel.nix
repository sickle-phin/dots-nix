{ config, ... }:
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
        terminal = "wezterm start --";
        launch-prefix = "env LANG=ja_JP.UTF-8 uwsm-app -- ";
        lines = 10;
        width = 25;
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
