{ pkgs, ... }:
{
  home.packages = with pkgs; [
    slack
    teams-for-linux
    vesktop
  ];

  xdg.dataFile = {
    "applications/slack.desktop" = {
      source = ./slack.desktop;
    };
    "applications/teams-for-linux.desktop" = {
      source = ./teams-for-linux.desktop;
    };
  };
}
