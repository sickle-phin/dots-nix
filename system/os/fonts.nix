{ pkgs, ... }:
{
  fonts = {
    packages = with pkgs; [
      noto-fonts-cjk-serif
      noto-fonts-cjk-sans
      # noto-fonts-emoji
      plemoljp-hs
      plemoljp-nf
      font-awesome
      "${pkgs.fetchzip {
        url = "https://github.com/yuru7/moralerspace/releases/download/v1.0.2/MoralerspaceNF_v1.0.2.zip";
        sha256 = "sha256-vBpHwtVxsojiM/B6+Ntwh9WX3gyklHpt1GHsE5QFTjc=";
      }}"
      (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
    ];
    fontDir.enable = true;

    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [
          "Noto Serif CJK JP"
          "Apple Color Emoji"
          "Symbols Nerd Font"
        ];
        sansSerif = [
          "Noto Sans CJK JP"
          "Apple Color Emoji"
          "Symbols Nerd Font"
        ];
        monospace = [
          "Noto Sans Mono CJK JP"
          "Apple Color Emoji"
          "Symbols Nerd Font Mono"
        ];
        emoji = [ "Apple Color Emoji" ];
      };
    };
  };
}
