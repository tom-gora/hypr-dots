#!/bin/env bash

bell="$HOME/.config/swaync/images/bell.svg"

STATE=$(hyprctl -j getoption decoration:blur:passes | jq ".int")

swaync-client --close-latest
if [ "${STATE}" == "3" ]; then
	hyprctl keyword decoration:blur:size 1
	hyprctl keyword decoration:blur:passes 1
	notify-send -e -u low -i "$bell" "Mini blur"
else
	hyprctl keyword decoration:blur:size 5
	hyprctl keyword decoration:blur:passes 3
	notify-send -e -u low -i "$bell" "Max blur"
fi
