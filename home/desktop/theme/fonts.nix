{ pkgs
, ...
}: let
  appleColorEmoji = "${pkgs.fetchurl {
    url="https://github.com/samuelngs/apple-emoji-linux/releases/download/v17.4/AppleColorEmoji.ttf";
    sha256 = "1wahjmbfm1xgm58madvl21451a04gxham5vz67gqz1cvpi0cjva8";
  }}";
in {
  xdg.dataFile = {
    "fonts/AppleColorEmoji.ttf" = {
      source = appleColorEmoji;
    };
  };
}
