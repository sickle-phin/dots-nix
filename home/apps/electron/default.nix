{
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    discord
    slack
  ];

  xdg.dataFile = {
    "applications/discord.desktop" = {
      source = ./discord.desktop;
    };
    "applications/slack.desktop" = {
      source = ./slack.desktop;
    };
  };
}
