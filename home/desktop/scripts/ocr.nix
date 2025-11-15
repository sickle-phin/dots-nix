{ pkgs, ... }:
let
  ocr = pkgs.writeShellScriptBin "ocr" ''
    #!/usr/bin/env bash

    OCR_LANG=$1
    CAPITAL=$(echo "$OCR_LANG" | tr '[:lower:]' '[:upper:]')
    if OCR=$(wl-paste | tesseract - - -l "$OCR_LANG"); then
        notify-send -a OCR -u "low" -i "ocrfeeder" "OCR Processing: Success" "$CAPITAL text copied to the clipboard"
        echo "$OCR" | wl-copy
    else
        notify-send -a OCR -u "critical" -i "ocrfeeder" "OCR Processing: Failure" "Please copy image to the clipboard"
        exit 1
    fi
  '';
in
{
  home.packages = [ ocr ];
}
