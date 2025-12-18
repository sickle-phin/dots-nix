{
  inputs,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib.meta) getExe;
  dms = getExe inputs.dank-material-shell.packages.${pkgs.stdenv.hostPlatform.system}.dms-shell;
  ocr = pkgs.writeShellScriptBin "ocr" ''
    OCR_LANG=$1
    CAPITAL=$(echo "$OCR_LANG" | tr '[:lower:]' '[:upper:]')
    if OCR=$(${dms} cl paste | tesseract - - -l "$OCR_LANG"); then
        notify-send -a OCR -u "low" -i "ocrfeeder" "OCR Processing: Success" "$CAPITAL text copied to the clipboard"
        echo "$OCR" | ${dms} cl copy
    else
        notify-send -a OCR -u "critical" -i "ocrfeeder" "OCR Processing: Failure" "Please copy image to the clipboard"
        exit 1
    fi
  '';
in
{
  home.packages = [ ocr ];
}
