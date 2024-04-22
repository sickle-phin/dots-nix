{ config, pkgs, ... }:

{
  services.mako = {
    enable = true;
  };

  xdg.configFile = {
    "mako/config" = {
      source = ./config;
    };
    "mako/icons" = {
      source = ./icons;
      recursive = true;
    };
  };

}
