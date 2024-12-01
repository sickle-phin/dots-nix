{ inputs, ... }:
{
  imports = [
    ./dconf.nix
    ./fonts.nix
    ./gtk.nix
    ./qt.nix
    inputs.catppuccin.homeManagerModules.catppuccin
  ];

  catppuccin = {
    accent = "pink";
    flavor = "mocha";
  };
}
