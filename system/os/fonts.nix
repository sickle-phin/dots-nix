{ pkgs, ... }:
{
  fonts = {
    packages = builtins.attrValues {
      inherit (pkgs)
        noto-fonts-cjk-serif
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
        mona-sans
        moralerspace-hw
        font-awesome
        ;
      inherit (pkgs.nerd-fonts) symbols-only;
    };
    fontDir = {
      enable = true;
      decompressFonts = true;
    };

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
