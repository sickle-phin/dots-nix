{ lib, pkgs, ... }:
let
  inherit (lib.modules) mkDefault;
in
{
  home.packages = builtins.attrValues {
    inherit (pkgs.catppuccin-cursors)
      latteLight
      mochaDark
      ;
  };

  home.pointerCursor = {
    enable = true;
    package = mkDefault pkgs.catppuccin-cursors.mochaDark;
    name = mkDefault "catppuccin-mocha-dark-cursors";
  };

  specialisation = {
    dark.configuration.home.pointerCursor = {
      package = pkgs.catppuccin-cursors.mochaDark;
      name = "catppuccin-mocha-dark-cursors";
    };
    light.configuration.home.pointerCursor = {
      package = pkgs.catppuccin-cursors.latteLight;
      name = "catppuccin-latte-light-cursors";
    };
  };
}
