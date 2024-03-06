{ config, pkgs, ... }:

{
  services.mako = {
    enable = true;
  };

  xdg.configFile = {
    "mako/config" = {
      source = ./config;
      force = true;
    };
  };

}
