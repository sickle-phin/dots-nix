{ inputs
, ...
}: {
  imports = [
    ./fonts.nix
    ./gtk.nix
    ./qt.nix
    inputs.catppuccin.homeManagerModules.catppuccin
  ];
  catppuccin.flavor = "mocha";
}
