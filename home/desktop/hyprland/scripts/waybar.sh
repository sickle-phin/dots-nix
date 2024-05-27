#!/usr/bin/env bash

if [[ "$HOST" -eq "pink" ]]; then
    pidof waybar || waybar -c ~/.config/waybar/config_laptop
else
    pidof waybar || waybar -c ~/.config/waybar/config_desktop
fi
