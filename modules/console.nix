{ pkgs
, config
, lib
, inputs
, ...
}:{
  imports = [ inputs.catppuccin.nixosModules.catppuccin ];
  catppuccin.flavor = "mocha";
  console.catppuccin.enable = true;
  console.earlySetup = true;
  services.kmscon = {
    enable = true;
    hwRender = true;
    fonts = [
      { name = "PlemolJP Console NF"; package = pkgs.plemoljp-nf; }
    ];
    extraConfig = let
      inherit (config.catppuccin) sources;
      cfg = config.console.catppuccin;
      palette = (lib.importJSON "${sources.palette}/palette.json").${cfg.flavor}.colors;
      paletteEntry = color: "palette-${color.name}=${toString color.rgb.r}, ${toString color.rgb.g}, ${toString color.rgb.b}";
      paletteConfig = builtins.concatStringsSep "\n" (map paletteEntry [
        { name = "black"; rgb = palette.base.rgb; }
        { name = "red"; rgb = palette.red.rgb; }
        { name = "green"; rgb = palette.green.rgb; }
        { name = "yellow"; rgb = palette.yellow.rgb; }
        { name = "blue"; rgb = palette.blue.rgb; }
        { name = "magenta"; rgb = palette.pink.rgb; }
        { name = "cyan"; rgb = palette.teal.rgb; }
        { name = "light-grey"; rgb = palette.subtext1.rgb; }
        { name = "dark-grey"; rgb = palette.surface2.rgb; }
        { name = "light-red"; rgb = palette.red.rgb; }
        { name = "light-green"; rgb = palette.green.rgb; }
        { name = "light-yellow"; rgb = palette.yellow.rgb; }
        { name = "light-blue"; rgb = palette.blue.rgb; }
        { name = "light-magenta"; rgb = palette.pink.rgb; }
        { name = "light-cyan"; rgb = palette.teal.rgb; }
        { name = "white"; rgb = palette.subtext0.rgb; }
        { name = "foreground"; rgb = palette.text.rgb; }
        { name = "background"; rgb = palette.base.rgb; }
      ]);
      key-layout =
        if (config.networking.hostName == "labo")
        then "jp"
        else "us"
      ;
    in ''
      font-size=20
      xkb-layout=${key-layout}
      xkb-repeat-delay=250
      xkb-repeat-rate=20
      palette=custom
      ${paletteConfig}
    '';
  };
}
