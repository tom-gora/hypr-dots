#!/bin/bash
# Scripts for refreshing waybar, rofi, swaync, pywal colors

SCRIPTSDIR=$HOME/.config/hypr/scripts

# Define file_exists function
file_exists() {
	if [ -e "$1" ]; then
		return 0 # File exists
	else
		return 1 # File does not exist
	fi
}

# Kill already running processes
_ps=(waybar rofi swaync)
for _prs in "${_ps[@]}"; do
	if pidof "${_prs}" >/dev/null; then
		pkill "${_prs}"
	fi
done

sleep 0.3
# Relaunch waybar
waybar &

# relaunch swaync
sleep 0.5
swaync >/dev/null 2>&1 &

exit 0
