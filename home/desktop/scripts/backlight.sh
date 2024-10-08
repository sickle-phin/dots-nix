#!/usr/bin/env bash

iDIR="$HOME/dots-nix/home/desktop/icons/"

# Get brightness
get_backlight() {
	LIGHT=$(printf "%.0f\n" $(brightnessctl g))
	echo "${LIGHT}"
}

# Get icons
get_icon() {
	current="$(get_backlight)"
	if [[ ("$current" -ge "0") && ("$current" -le "19200") ]]; then
		icon="$iDIR/brightness-20.png"
	elif [[ ("$current" -ge "19200") && ("$current" -le "38400") ]]; then
		icon="$iDIR/brightness-40.png"
	elif [[ ("$current" -ge "38400") && ("$current" -le "57600") ]]; then
		icon="$iDIR/brightness-60.png"
	elif [[ ("$current" -ge "57600") && ("$current" -le "76800") ]]; then
		icon="$iDIR/brightness-80.png"
	elif [[ ("$current" -ge "76800") && ("$current" -le "96000") ]]; then
		icon="$iDIR/brightness-100.png"
	fi
}

# Notify
notify_user() {
	notify-send -h string:x-canonical-private-synchronous:sys-notify -u low -i "$icon" "Brightness : $(get_backlight)"
}

# Increase brightness
inc_backlight() {
    for i in {1..5}
    do
        brightnessctl s +1%
        sleep 0.02
    done
    get_icon && notify_user
}

# Decrease brightness
dec_backlight() {
    MAX=$(brightnessctl m)
    NOW=$(brightnessctl g)
    RESULT=$((100 * NOW / MAX))
    if [[ (5 -lt $RESULT) ]]; then
        for i in {1..5}
        do
            brightnessctl s 1%-
            sleep 0.02
        done
        get_icon && notify_user
    fi
}

function IsRunning() {
    if [ $$ -ne $(pgrep -fo "$0") ]; then
        exit 1
    fi
}

# Execute accordingly
IsRunning

if [[ "$1" == "--get" ]]; then
	get_backlight
elif [[ "$1" == "--inc" ]]; then
	inc_backlight
elif [[ "$1" == "--dec" ]]; then
	dec_backlight
else
	get_backlight
fi
