#!/usr/bin/env bash

WALL_DIR=$1

PICS=($(ls "${WALL_DIR}"))
MONITOR_INFO=$(hyprctl monitors)
MONITORS=($(echo "$MONITOR_INFO" | grep "Monitor" | awk '{print $2}'))

wall_menu() {
    for i in "${!PICS[@]}"; do
        printf "${PICS[$i]}\0icon\x1f${WALL_DIR}/${PICS[$i]}\n"
    done
}

monitor_menu() {
    for i in "${!MONITORS[@]}"; do
        echo "${MONITORS[$i]}"
    done
}

main() {
    pick=$(wall_menu | rofi -dmenu -p " Wallpapers" -config ~/.config/rofi/config_wallpaper.rasi)
    if [[ -z $pick ]]; then
        exit 0
    fi
    image_path="${WALL_DIR}/${pick}"

    monitor=$(monitor_menu | rofi -dmenu -p " Displays")

    if [[ -z $monitor ]]; then
        exit 0
    fi

    swww img --outputs "${monitor}" "${image_path}"
}

swww query || swww-daemon
main
