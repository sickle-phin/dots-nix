{ pkgs, ... }:
{
  home.pointerCursor = {
    package = pkgs.catppuccin-cursors.mochaDark;
    name = "catppuccin-mocha-dark-cursors";
    size = 32;
    x11.enable = false;
    gtk.enable = true;
  };
}
