#!/usr/bin/env bash

host=$(hostname)
if [[ $host = "pink" ]]; then
    pidof waybar || waybar
else
    pidof waybar || waybar
fi
