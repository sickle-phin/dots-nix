{ lib, pkgs, ... }:
let
  inherit (lib.modules) mkDefault;
in
{
  home = {
    sessionVariables = {
      HYPRCURSOR_THEME = "catppuccin-mocha-dark-cursors";
      HYPRCURSOR_SIZE = 37;
      XCURSOR_SIZE = 34;
    };

    packages = builtins.attrValues {
      inherit (pkgs.catppuccin-cursors)
        latteLight
        mochaDark
        ;
    };

    pointerCursor = {
      enable = true;
      package = mkDefault pkgs.catppuccin-cursors.mochaDark;
      name = mkDefault "catppuccin-mocha-dark-cursors";
      size = 34;
    };
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
