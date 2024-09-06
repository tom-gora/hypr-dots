#!/bin/bash
## Script for changing blurs on the fly

bell="$HOME/.config/swaync/images/bell.svg"

STATE=$(hyprctl -j getoption decoration:blur:passes | jq ".int")

if [ "${STATE}" == "2" ]; then
	hyprctl keyword decoration:blur:size 1
	hyprctl keyword decoration:blur:passes 1
	notify-send -e -u low -i "$bell" "Mini blur"
else
	hyprctl keyword decoration:blur:size 10
	hyprctl keyword decoration:blur:passes 2
	notify-send -e -u low -i "$bell" "Max blur"
fi
