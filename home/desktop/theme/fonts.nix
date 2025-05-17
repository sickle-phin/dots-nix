{ pkgs, ... }:
let
  appleColorEmoji = pkgs.fetchurl {
    url = "https://github.com/samuelngs/apple-emoji-linux/releases/download/v18.4/AppleColorEmoji.ttf";
    sha256 = "sha256-pP0He9EUN7SUDYzwj0CE4e39SuNZ+SVz7FdmUviF6r0=";
  };
in
{
  xdg.dataFile = {
    "fonts/AppleColorEmoji.ttf" = {
      source = appleColorEmoji;
    };
  };
}
