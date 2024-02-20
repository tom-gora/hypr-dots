#!/bin/bash
# Modified version of Refresh but no waybar refresh
# Used by automatic wallpaper change
# Modified inorder to refresh rofi background, Pywal, SwayNC

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
_ps=(rofi)
for _prs in "${_ps[@]}"; do
	if pidof "${_prs}" >/dev/null; then
		pkill "${_prs}"
	fi
done

# Pywal refresh
${SCRIPTSDIR}/wallpaperAndStyle/PywalSwww.sh &

exit 0
