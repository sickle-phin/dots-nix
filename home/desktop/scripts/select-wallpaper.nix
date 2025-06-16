{
  inputs,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib.meta) getExe;

  select-wallpaper = pkgs.writeShellScriptBin "select-wallpaper" ''
    #!/usr/bin/env bash

    THUMBNAIL_SIZE=80
    THUMBNAIL_DIR="''${XDG_CACHE_HOME:-$HOME/.cache}/wallpaper"
    WALLPAPER_DIR="${inputs.wallpaper}/wallpaper"

    # Check if wallpaper directory contains files
    if ! ls "$WALLPAPER_DIR"/* &>/dev/null; then
        ${getExe pkgs.fuzzel} -d --placeholder "Wallpaper: please store something first" --lines 0
        rm -rf "$THUMBNAIL_DIR"
        exit 1
    fi

    # Ensure thumbnail directory exists
    [ -d "$THUMBNAIL_DIR" ] || mkdir -p "$THUMBNAIL_DIR"

    # Cleanup: remove thumbnails no longer associated with files
    ${getExe pkgs.fd} . "$THUMBNAIL_DIR" --type f | while read -r thumb; do
        thumb_base="$(basename "''${thumb%.*}")"
        if ! ${getExe pkgs.fd} -q "^$thumb_base.*$" "$WALLPAPER_DIR"; then
            rm -f "$thumb"
        fi
    done

    # Build menu of wallpapers with thumbnails
    generate_wallpaper_menu() {
        for file in "$WALLPAPER_DIR"/*; do
            [ -f "$file" ] || continue
            base_name="$(basename "$file" | sed 's/\.[^.]*$//')"
            thumbnail_path="''${THUMBNAIL_DIR}/''${base_name}.png"

            if [ ! -f "$thumbnail_path" ]; then
                ${getExe pkgs.imagemagick} "$file" -thumbnail "''${THUMBNAIL_SIZE}^" -resize "$THUMBNAIL_SIZE" "$thumbnail_path"
            fi

            printf "%s\0icon\x1f%s\n" "$(basename "$file")" "$thumbnail_path"
        done
    }

    # User selects wallpaper
    selected_wallpaper=$(generate_wallpaper_menu | ${getExe pkgs.fuzzel} -d --placeholder "Select wallpaper..." --line-height 38)
    [[ -z $selected_wallpaper ]] && exit 0

    # Get monitor list from hyprctl
    mapfile -t monitors < <(hyprctl monitors | awk '/Monitor/ {print $2}')

    # User selects monitor
    selected_monitor=$(printf "%s\n" "''${monitors[@]}" | ${getExe pkgs.fuzzel} -d --placeholder "Select monitor..." --no-sort)
    [[ -z $selected_monitor ]] && exit 0

    # Set wallpaper
    image_path="''${WALLPAPER_DIR}/''${selected_wallpaper}"
    ${getExe pkgs.swww} img --outputs "$selected_monitor" "$image_path"
  '';
in
{
  home.packages = [ select-wallpaper ];
}
