# WALLPAPERS PATH
wallDIR="$HOME/.config/hypr/images"

# Retrieve image files
PICS=($(ls "${wallDIR}"))

# Rofi command
rofi_command="wofi --dmenu --conf $HOME/.config/wofi/config_wallpaper"

menu() {
    for i in "${!PICS[@]}"; do
        printf "img:${wallDIR}/${PICS[$i]}:text:${PICS[$i]}\n"
    done
}

swww query || swww init

main() {
    choice=$(menu | ${rofi_command})
    if [[ $choice =~ img:(.+?):text ]]; then
        image_path=${BASH_REMATCH[1]}
    fi

  # No choice case
  if [[ -z $image_path ]]; then
      exit 0
  fi

  swww img "${image_path}"
}

main
