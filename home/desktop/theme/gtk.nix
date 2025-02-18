{ pkgs, ... }:
{
  home.packages =
    let
      catppuccin-latte = pkgs.catppuccin-gtk.override {
        accents = [ "pink" ];
        size = "standard";
        tweaks = [ "normal" ];
        variant = "latte";
      };
      catppuccin-mocha = pkgs.catppuccin-gtk.override {
        accents = [ "pink" ];
        size = "standard";
        tweaks = [ "normal" ];
        variant = "mocha";
      };
    in
    builtins.attrValues {
      inherit catppuccin-latte;
      inherit catppuccin-mocha;
      inherit (pkgs.catppuccin-cursors)
        latteLight
        mochaDark
        ;
      inherit (pkgs)
        dracula-theme
        everforest-gtk-theme
        gruvbox-gtk-theme
        nordic

        capitaine-cursors-themed
        nordzy-cursor-theme

        dracula-icon-theme
        papirus-icon-theme
        ;
    };
}
