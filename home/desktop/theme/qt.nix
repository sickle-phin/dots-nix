{ pkgs, ... }:
let
  catppuccin-latte = pkgs.catppuccin-kvantum.override {
    accent = "pink";
    variant = "latte";
  };
  catppuccin-mocha-green = pkgs.catppuccin-kvantum.override {
    accent = "green";
    variant = "mocha";
  };
  catppuccin-mocha-pink = pkgs.catppuccin-kvantum.override {
    accent = "pink";
    variant = "mocha";
  };
  gruvbox-dark = pkgs.gruvbox-kvantum.override {
    variant = "Gruvbox-Dark-Blue";
  };
  gruvbox-light = pkgs.gruvbox-kvantum.override {
    variant = "Gruvbox_Light_Blue";
  };
in
{
  qt = {
    enable = true;
    platformTheme.name = "kvantum";
    style.name = "kvantum";
  };

  home.packages = builtins.attrValues {
    inherit catppuccin-latte;
    inherit catppuccin-mocha-green;
    inherit catppuccin-mocha-pink;
    inherit gruvbox-dark;
    inherit gruvbox-light;
  };

  xdg.configFile = {
    "Kvantum/Dracula-purple".source = "${pkgs.dracula-theme}/share/Kvantum/Dracula-purple";
    "Kvantum/catppuccin-latte-pink".source = "${catppuccin-latte}/share/Kvantum/catppuccin-latte-pink";
    "Kvantum/catppuccin-mocha-green".source =
      "${catppuccin-mocha-green}/share/Kvantum/catppuccin-mocha-green";
    "Kvantum/catppuccin-mocha-pink".source =
      "${catppuccin-mocha-pink}/share/Kvantum/catppuccin-mocha-pink";
    "Kvantum/Gruvbox-Dark-Blue".source = "${gruvbox-dark}/share/Kvantum/Gruvbox-Dark-Blue";
    "Kvantum/Gruvbox_Light_Blue".source = "${gruvbox-light}/share/Kvantum/Gruvbox_Light_Blue";
    "Kvantum/Nordic".source = "${pkgs.nordic}/share/Kvantum/Nordic";
  };
}
