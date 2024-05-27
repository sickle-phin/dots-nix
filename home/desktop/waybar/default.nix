{ pkgs
, ...
}: {
  programs.waybar = {
    enable = true;
  };
  xdg.configFile = {
    "waybar/config_desktop" = {
      source = ./config_desktop;
    };
    "waybar/config_laptop" = {
      source = ./config_laptop;
    };
    "waybar/style.css" = {
      source = ./style.css;
    };
  };
}
