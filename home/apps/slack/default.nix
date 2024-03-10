{
  lib,
  pkgs,
  catppuccin-bat,
  ...
}: {
  home.packages = with pkgs; [
    slack
  ];
  xdg.dataFile = {
    "applications/slack.desktop" = {
      source = ./slack.desktop;
    };
  };
}
