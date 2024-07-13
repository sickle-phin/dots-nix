#!/usr/bin/env bash

CONFIGS[0]="border"
CONFIGS[1]="blur"
CONFIGS[2]="shadow"

PICKER="wofi --dmenu --prompt configs"

config_menu() {
    for i in "${!CONFIGS[@]}"; do
        echo "${CONFIGS[$i]}"
    done
}

main() {
    pick=$(config_menu | ${PICKER})

    if [[ -z $pick ]]; then
        exit 0
    fi

    if [[ $pick = "${CONFIGS[0]}" ]]; then
        border_size=$(hyprctl getoption general:border_size | head -n 1 | awk '{print $2}')
        if [[ border_size -eq 0 ]]; then
            hyprctl keyword general:border_size 2
        else
            hyprctl keyword general:border_size 0
        fi
    elif [[ $pick = "${CONFIGS[1]}" ]]; then
        blur=$(hyprctl getoption decoration:blur:enabled | head -n 1 | awk '{print $2}')
        if [[ blur -eq 0 ]]; then
            hyprctl keyword decoration:blur:enabled 1
        else
            hyprctl keyword decoration:blur:enabled 0
        fi
    elif [[ $pick = "${CONFIGS[2]}" ]]; then
        shadow=$(hyprctl getoption decoration:drop_shadow | head -n 1 | awk '{print $2}')
        if [[ shadow -eq 0 ]]; then
            hyprctl keyword decoration:drop_shadow 1
        else
            hyprctl keyword decoration:drop_shadow 0
        fi
    fi
}

main
