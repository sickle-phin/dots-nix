{ pkgs, ... }:
{
  fonts = {
    packages =
      let
        apple-color-emoji = pkgs.stdenvNoCC.mkDerivation {
          name = "Apple Color Emoji";
          src = pkgs.fetchurl {
            url = "https://github.com/samuelngs/apple-emoji-linux/releases/latest/download/AppleColorEmoji.ttf";
            sha256 = "sha256-pP0He9EUN7SUDYzwj0CE4e39SuNZ+SVz7FdmUviF6r0=";
          };
          phases = [ "installPhase" ];
          installPhase = ''
            mkdir -p $out/share/fonts/truetype
            cp $src $out/share/fonts/truetype/AppleColorEmoji.ttf
          '';
        };
      in
      builtins.attrValues {
        inherit (pkgs)
          noto-fonts-cjk-serif
          noto-fonts-cjk-sans
          noto-fonts-color-emoji
          mona-sans
          moralerspace-hw
          font-awesome
          ;
        inherit (pkgs.nerd-fonts) symbols-only;
        inherit apple-color-emoji;
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
