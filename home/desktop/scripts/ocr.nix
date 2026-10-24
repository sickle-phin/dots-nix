{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib.meta) getExe;
  dms = getExe config.programs.dank-material-shell.package;
  ocr = pkgs.writeShellScriptBin "ocr" ''
    set -o pipefail
    if [[ $# -ne 1 ]]; then
        printf 'Usage: ocr <language>\n' >&2
        exit 1
    fi
    OCR_LANG=$1
    CAPITAL=$(echo "$OCR_LANG" | tr '[:lower:]' '[:upper:]')
    if OCR=$(${dms} cl paste | tesseract - - -l "$OCR_LANG"); then
        if ! printf '%s' "$OCR" | ${dms} cl copy; then
            notify-send -a OCR -u "critical" -i "ocrfeeder" "OCR Processing: Failure" "Failed to copy text to the clipboard"
            exit 1
        fi
        notify-send -a OCR -u "low" -i "ocrfeeder" "OCR Processing: Success" "$CAPITAL text copied to the clipboard"
        exit 0
    else
        notify-send -a OCR -u "critical" -i "ocrfeeder" "OCR Processing: Failure" "Please copy image to the clipboard"
        exit 1
    fi
  '';
in
{
  home.packages = [ ocr ];
}
