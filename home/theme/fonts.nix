{ config, pkgs, ... }:

{
  xdg.dataFile = {
    "fonts/AppleColorEmoji.ttf" = {
      source = ./AppleColorEmoji.ttf;
    };
  };
}
