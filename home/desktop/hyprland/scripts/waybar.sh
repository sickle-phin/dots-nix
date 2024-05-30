#!/usr/bin/env bash

if [[ $HOST = "pink" ]]; then
    pidof waybar || waybar -c ~/.config/waybar/config_laptop
else
    pidof waybar || waybar -c ~/.config/waybar/config_desktop
fi
