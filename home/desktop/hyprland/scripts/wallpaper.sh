#!/usr/bin/env bash

WALL_DIR="$HOME/.config/hypr/images"

PICS=($(ls "${WALL_DIR}"))
MONITORS=($(xrandr | grep -w connected | awk '{print $1}'))

WALL_PICKER="wofi --dmenu --conf $HOME/.config/wofi/config_wallpaper"
MONITOR_PICKER="wofi --dmenu --prompt monitors"

wall_menu() {
    for i in "${!PICS[@]}"; do
        printf "img:${WALL_DIR}/${PICS[$i]}:text:${PICS[$i]}\n"
    done
}

monitor_menu() {
    for i in "${!MONITORS[@]}"; do
        echo "${MONITORS[$i]}"
    done
}

main() {
    pick=$(wall_menu | ${WALL_PICKER})
    if [[ $pick =~ img:(.+?):text ]]; then
        image_path=${BASH_REMATCH[1]}
    fi

    if [[ -z $image_path ]]; then
        exit 0
    fi

    monitor=$(monitor_menu | ${MONITOR_PICKER})

    if [[ -z $monitor ]]; then
        exit 0
    fi

    swww img --outputs "${monitor}" "${image_path}"
}

swww query || swww init
main
