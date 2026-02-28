{ pkgs, ... }:
{
  fonts = {
    packages =
      let
        apple-color-emoji = pkgs.stdenvNoCC.mkDerivation {
          name = "Apple Color Emoji";
          src = pkgs.fetchurl {
            url = "https://github.com/samuelngs/apple-emoji-ttf/releases/latest/download/AppleColorEmoji-Linux.ttf";
            sha256 = "sha256-U1oEOvBHBtJEcQWeZHRb/IDWYXraLuo0NdxWINwPUxg=";
          };
          phases = [ "installPhase" ];
          installPhase = ''
            mkdir -p $out/share/fonts/truetype
            cp $src $out/share/fonts/truetype/AppleColorEmoji.ttf
          '';
        };
        moralerspace-hw = pkgs.fetchzip {
          url = "https://github.com/yuru7/moralerspace/releases/download/v1.1.0/MoralerspaceHW_v1.1.0.zip";
          sha256 = "sha256-V02Lp7bWKjUGhFJ5fOTVrk74ei0T5UtITQeHZ4OHytw=";
        };
      in
      builtins.attrValues {
        inherit (pkgs)
          inter
          noto-fonts-cjk-serif
          noto-fonts-cjk-sans
          noto-fonts-color-emoji
          # moralerspace-hw
          font-awesome
          ;
        inherit (pkgs.nerd-fonts) symbols-only;
        inherit apple-color-emoji;
        inherit moralerspace-hw;
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
