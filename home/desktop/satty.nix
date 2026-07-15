{
  config,
  lib,
  ...
}:
let
  inherit (lib.meta) getExe;
  dms = getExe config.programs.dank-material-shell.package;
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
          "Symbols Nerd Font"
        ];
      };
    };
  };
}
