#!/bin/env bash

WAYBAR_STYLES_FILE="$HOME/.config/waybar/style.css"

if [ ! -f "$WAYBAR_STYLES_FILE" ]; then
	echo "Error: File not found at $WAYBAR_STYLES_FILE"
	pkill waybar
	sleep 1
	waybar &
fi

CURRENT_CONTENT=$(<"$WAYBAR_STYLES_FILE")
printf "%s" "$CURRENT_CONTENT" >"$WAYBAR_STYLES_FILE"
if [ "$?" -ne 0 ]; then
	echo "Error: Failed trigger waybar's hot reload."
fi
