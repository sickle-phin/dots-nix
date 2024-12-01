{ pkgs, ... }:
{
  # gtk = {
  #   enable = true;
  #   catppuccin = {
  #     icon.enable = true;
  #   };
  #
  #   gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
  #
  #   font = {
  #     name = "Noto Sans CJK JP";
  #     size = 11;
  #   };
  #
  #   theme = {
  #     package = pkgs.catppuccin-gtk.override {
  #       accents = [ "mauve" ];
  #       size = "standard";
  #       tweaks = [ "normal" ];
  #       variant = "mocha";
  #     };
  #     name = "catppuccin-mocha-mauve-standard+normal";
  #   };
  # };

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
      inherit (pkgs)
        dracula-theme

        dracula-icon-theme
        papirus-icon-theme
        ;
    };
}
