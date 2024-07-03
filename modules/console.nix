{ pkgs
, inputs
, ...
}:{
  imports = [ inputs.catppuccin.nixosModules.catppuccin ];
  catppuccin.flavor = "mocha";
  console.catppuccin.enable = true;
  console.earlySetup = true;
  services.kmscon = {
    enable = false;
    hwRender = true;
    fonts = [
      { name = "PlemolJP Console NF"; package = pkgs.plemoljp-nf; }
    ];
    extraOptions = "--term xterm-256color";
    extraConfig = "font-size=20";
  };
}
