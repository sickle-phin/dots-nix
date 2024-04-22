#!/usr/bin/env bash

WALLPAPER=$(cat ~/.config/hypr/scripts/wallpaper.txt)
if [ -z "$WALLPAPER" ]; then
    WALLPAPER=2
fi
if [[ "$WALLPAPER" -eq "1" ]]; then
    swww img ~/.config/hypr/images/sickle.jpg
    WALLPAPER=2
elif [[ "$WALLPAPER" -eq "2" ]]; then
    swww img ~/.config/hypr/images/stocking.jpg
    WALLPAPER=1
fi
echo $WALLPAPER > ~/.config/hypr/scripts/wallpaper.txt
