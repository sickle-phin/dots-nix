{ pkgs
, ...
}:{
  fonts = {
    packages = with pkgs; [
      noto-fonts-cjk-serif
      noto-fonts-cjk-sans
      # noto-fonts-emoji
      plemoljp-hs
      plemoljp-nf
      font-awesome
      (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
    ];
    fontDir.enable = true;

    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [ "Noto Serif CJK JP" "Apple Color Emoji" "Symbols Nerd Font" ];
        sansSerif = [ "Noto Sans CJK JP" "Apple Color Emoji" "Symbols Nerd Font" ];
        monospace = [ "Noto Sans Mono CJK JP" "Apple Color Emoji" "Symbols Nerd Font Mono" ];
        emoji = [ "Apple Color Emoji" ];
      };
    };
  };
}
