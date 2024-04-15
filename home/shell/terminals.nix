{ pkgs, ... }:

# terminals

let
  font = "PlemolJP Console NF";
in
{
  programs.alacritty = {
    enable = true;
    catppuccin.enable = true;
    settings = {
      window.opacity = 0.60;
      window.dynamic_padding = true;
      window.padding = {
        x = 5;
        y = 5;
      };
      scrolling.history = 10000;

      font = {
        normal.family = font;
        bold.family = font;
        italic.family = font;
        size = 17;
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
