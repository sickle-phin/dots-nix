{ pkgs, ... }:
let
  catppuccin-latte = pkgs.catppuccin-kvantum.override {
    accent = "pink";
    variant = "latte";
  };
  catppuccin-mocha = pkgs.catppuccin-kvantum.override {
    accent = "pink";
    variant = "mocha";
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
    inherit catppuccin-mocha;
  };

  xdg.configFile = {
    "Kvantum/Dracula-purple".source = "${pkgs.dracula-theme}/share/Kvantum/Dracula-purple";
    "Kvantum/catppuccin-latte-pink".source = "${catppuccin-latte}/share/Kvantum/catppuccin-latte-pink";
    "Kvantum/catppuccin-mocha-pink".source = "${catppuccin-mocha}/share/Kvantum/catppuccin-mocha-pink";
  };
}
