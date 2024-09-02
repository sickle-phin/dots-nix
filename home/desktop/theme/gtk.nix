{ pkgs, ... }:
{
  gtk = {
    enable = true;
    catppuccin = {
      icon.enable = true;
    };

    theme = {
      name = "catppuccin-mocha-mauve-standard+normal";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "mauve" ];
        size = "standard";
        tweaks = [ "normal" ];
        variant = "mocha";
      };
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
