{ pkgs, ... }:
{
  gtk = {
    enable = true;
    catppuccin = {
      enable = true;
      icon.enable = true;
    };

    cursorTheme = {
      name = "catppuccin-mocha-dark-cursors";
      package = pkgs.catppuccin-cursors.mochaDark;
      size = 29;
    };

    font = {
      name = "Noto Sans CJK JP";
      size = 11;
    };
  };
}
