{ pkgs, ... }:
let
  catppuccin-latte = pkgs.catppuccin-kvantum.override {
    accent = "pink";
    variant = "latte";
  };
  catppuccin-mocha-pink = pkgs.catppuccin-kvantum.override {
    accent = "pink";
    variant = "mocha";
  };
in
{
  qt = {
    enable = true;
    style.name = "kvantum";
  };

  home.packages = builtins.attrValues {
    inherit catppuccin-latte;
    inherit catppuccin-mocha-pink;
  };

  xdg.configFile = {
    "Kvantum/catppuccin-latte-pink".source = "${catppuccin-latte}/share/Kvantum/catppuccin-latte-pink";
    "Kvantum/catppuccin-mocha-pink".source =
      "${catppuccin-mocha-pink}/share/Kvantum/catppuccin-mocha-pink";
  };
}
