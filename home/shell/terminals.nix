{ pkgs, lib, ... }:

# terminals

let
  font = "PlemolJP Console NF";
in
{
  programs.alacritty = {
    enable = true;
    catppuccin.enable = true;
    settings = {
      window = {
        dimensions = {
          columns = 80;
          lines = 25;
        };
        opacity = 0.60;
        dynamic_padding = true;
        padding = {
          x = 5;
          y = 5;
        };
      };
      scrolling.history = 10000;

      font = {
        normal.family = font;
        bold.family = font;
        italic.family = font;
        size = 19.5;
      };
      colors = {
        primary.background = lib.mkForce "#000000";
        cursor = {
          text = lib.mkForce "#000000";
          cursor = lib.mkForce "#f4b7d6";
        };
      };
    };
  };

  programs.wezterm = {
    enable = true;
  };
  xdg.configFile = {
    "wezterm/wezterm.lua" = {
      source = ./wezterm.lua;
    };
  };
}
