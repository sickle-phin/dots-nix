#!/usr/bin/env bash

host=$(hostname)
if [[ $host = "pink" ]]; then
    pidof waybar || waybar -c ~/.config/waybar/config_laptop
else
    pidof waybar || waybar -c ~/.config/waybar/config_desktop
fi
