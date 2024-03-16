{
  lib,
  pkgs,
  ...
}: {
  xdg.dataFile = {
    "applications/steam.desktop" = {
      source = ./steam.desktop;
    };
  };
}
