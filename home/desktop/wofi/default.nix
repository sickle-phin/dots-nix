{ pkgs
, ...
}: {
  programs.wofi = {
    enable = true;
  };
  xdg.configFile = {
    "wofi/colors" = {
      source = ./colors;
    };
  };
  xdg.configFile = {
    "wofi/config" = {
      source = ./config;
    };
  };
  xdg.configFile = {
    "wofi/config_wallpaper" = {
      source = ./config_wallpaper;
    };
  };
  xdg.configFile = {
    "wofi/style.css" = {
      source = ./style.css;
    };
  };
}
