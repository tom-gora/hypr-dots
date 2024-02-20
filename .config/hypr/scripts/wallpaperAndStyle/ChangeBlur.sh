#!/bin/bash
## Script for changing blurs on the fly

notif="$HOME/.config/swaync/images/bell.png"

STATE=$(hyprctl -j getoption decoration:blur:passes | jq ".int")

if [ "${STATE}" == "2" ]; then
	hyprctl keyword decoration:blur:size 1
	hyprctl keyword decoration:blur:passes 1
	notify-send -e -u low -i "$notif" "Mini blur"
else
	hyprctl keyword decoration:blur:size 10
	hyprctl keyword decoration:blur:passes 2
	notify-send -e -u low -i "$notif" "Max blur"
fi
