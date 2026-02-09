{
  inputs,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib.meta) getExe;
  dms = getExe inputs.dank-material-shell.packages.${pkgs.stdenv.hostPlatform.system}.dms-shell;
in
{
  programs.satty = {
    enable = true;
    settings = {
      general = {
        resize.mode = "smart";
        floating-hack = true;
        copy-command = "${dms} cl copy -t image/png";
      };
      font = {
        family = "Inter Variable";
        style = "Bold";
        fallback = [
          "Noto Sans CJK JP"
        ];
      };
    };
  };
}
