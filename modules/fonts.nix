{ pkgs
, ...
}:{
  fonts = {
    packages = with pkgs; [
      noto-fonts-cjk-serif
      noto-fonts-cjk-sans
      # noto-fonts-emoji
      font-awesome
      plemoljp-nf
      (nerdfonts.override { fonts = [ "RobotoMono" ]; })
    ];
    fontDir.enable = true;

    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [ "Noto Serif CJK JP" "Apple Color Emoji" ];
        sansSerif = [ "Noto Sans CJK JP" "Apple Color Emoji" ];
        monospace = [ "Noto Sans Mono CJK JP" "Apple Color Emoji" ];
        emoji = [ "Apple Color Emoji" ];
      };
    };
  };
}
