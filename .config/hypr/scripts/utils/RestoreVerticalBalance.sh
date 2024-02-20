#!/bin/bash

determine_monitor() {
	monitors_metadata=$(hyprctl monitors -j)
	focused_monitor=$(echo "$monitors_metadata" | jq '.[] | select(.focused == true)')
	current_monitor_side=$(echo "$focused_monitor" | jq -r '.x | if . == 0 then "left" elif . == 1920 then "right" else "unknown" end')
	echo "$current_monitor_side"
}
current_side=$(determine_monitor)

get_leftmost_window_pid() {
	local side=$1
	windows_metadata=$(hyprctl clients -j)

	if [ "$side" = "left" ]; then
		leftmost_window=$(echo "$windows_metadata" | jq -r '.[] | select(.at[0] < 10 and .at[0] >= 1)') # Only check first value in array
	elif [ "$side" = "right" ]; then
		leftmost_window=$(echo "$windows_metadata" | jq -r '.[] | select(.at[0] > 1920 and .at[0] < 1930)')
	else
		echo "Invalid side provided."
		return 1
	fi

	echo "$leftmost_window" | jq -r '.address'
}

leftmost_address=$(get_leftmost_window_pid "$current_side")

hyprctl dispatch resizewindowpixel exact 49% 51%,address:"$leftmost_address"
