{
  pkgs,
  config,
  ...
}:
{
  console = {
    earlySetup = true;
    colors = [
      "1e1e2e"
      "f38ba8"
      "a6e3a1"
      "f9e2af"
      "89b4fa"
      "f5c2e7"
      "94e2d5"
      "bac2de"

      "585b70"
      "f38ba8"
      "a6e3a1"
      "f9e2af"
      "89b4fa"
      "f5c2e7"
      "94e2d5"
      "a6adc8"
    ];

  };

  services.kmscon = {
    enable = true;
    hwRender = true;
    fonts = [
      {
        name = "PlemolJP Console NF";
        package = pkgs.plemoljp-nf;
      }
      {
        name = "Symbols Nerd Font Mono";
        package = pkgs.nerd-fonts.symbols-only;
      }
    ];
    extraConfig = ''
      font-size=20
      xkb-layout=${config.myOptions.kbLayout}
      xkb-repeat-delay=250
      xkb-repeat-rate=20
      palette=custom
      palette-black=30, 30, 46
      palette-red=243, 139, 168
      palette-green=166, 227, 161
      palette-yellow=249, 226, 175
      palette-blue=137, 180, 250
      palette-magenta=245, 194, 231
      palette-cyan=148, 226, 213
      palette-light-grey=186, 194, 222
      palette-dark-grey=88, 91, 112
      palette-light-red=243, 139, 168
      palette-light-green=166, 227, 161
      palette-light-yellow=249, 226, 175
      palette-light-blue=137, 180, 250
      palette-light-magenta=245, 194, 231
      palette-light-cyan=148, 226, 213
      palette-white=166, 173, 200
      palette-foreground=205, 214, 244
      palette-background=30, 30, 46
    '';
  };
}
