{
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    slack
    vesktop
  ];

  xdg.dataFile = {
    "applications/slack.desktop" = {
      source = ./slack.desktop;
    };
  };
}
