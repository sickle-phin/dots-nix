{ pkgs, ... }:
let
  appleColorEmoji = "${pkgs.fetchurl {
    url = "https://github.com/samuelngs/apple-emoji-linux/releases/download/v17.4/AppleColorEmoji.ttf";
    sha256 = "sha256-SG3JQLybhY/fMX+XqmB/BKhQSBB0N1VRqa+H6laVUPE=";
  }}";
in
{
  xdg.dataFile = {
    "fonts/AppleColorEmoji.ttf" = {
      source = appleColorEmoji;
    };
  };
}
