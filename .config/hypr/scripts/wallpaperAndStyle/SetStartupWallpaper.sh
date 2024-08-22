#!/bin/bash

#set -x

WALLPAPER=$(/usr/bin/find -L /usr/share/sddm/themes/simple-sddm/hook-into-system-wallpapers -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.gif" \) | shuf -n 1)

WALLPAPER_DECIDED_BY_SDDM=$(cat /tmp/initial-wallpaper)

REFRESH_SCRIPT="/home/tomeczku/.config/hypr/scripts/wallpaperAndStyle/RefreshNoWaybar.sh"

#check if sddm service at startup managed to select img for display manager, if so store it to keep consistent img for wallpaper
if [ -n "$WALLPAPER_DECIDED_BY_SDDM" ]; then
	#else fallback selected at the top of the script
	WALLPAPER="$WALLPAPER_DECIDED_BY_SDDM"
fi

#check if wallpaper daemon live from previous session
swww query >/dev/null
if [ $? -eq 1 ]; then
	# init wallpaper service then apply img with no transition effects
	swww init
	swww img "$WALLPAPER" --transition-type none
	$REFRESH_SCRIPT
else
	#the same action just no need to init service first
	swww img "$WALLPAPER" --transition-type none
	$REFRESH_SCRIPT
fi
