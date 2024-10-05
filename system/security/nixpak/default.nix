{
  pkgs,
  inputs,
  ...
}:
let
  callArgs = {
    mkNixPak = inputs.nixpak.lib.nixpak {
      inherit (pkgs) lib;
      inherit pkgs;
    };
    safeBind = sloth: realdir: mapdir: [
      (sloth.mkdir (sloth.concat' sloth.appDataDir realdir))
      (sloth.concat' sloth.homeDir mapdir)
    ];
  };
  wrapper = _pkgs: path: (_pkgs.callPackage path callArgs).config.script;
in
{
  nixpkgs.overlays = [
    (_: super: {
      nixpaks = {
        firefox = wrapper super ./firefox.nix;
      };
    })
  ];
}
