#!/bin/bash
set -x

determine_monitor() {
	monitors_metadata=$(hyprctl monitors -j)
	focused_monitor=$(echo "$monitors_metadata" | jq '.[] | select(.focused == true)')
	current_monitor_side=$(echo "$focused_monitor" | jq -r '.x | if . == 0 then "left" elif . == 1920 then "right" else "unknown" end')
	echo "$current_monitor_side"
}
current_side=$(determine_monitor)

get_leftmost_window_addr() {
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

leftmost_address=$(get_leftmost_window_addr "$current_side")

#TODO: This is a rudimentary solution to a bug breaking script when multiple
# workspaces are assigned to a single monitor causing multiple arressess to
# get concatentated. I could not precise selection work so for now rebalancing
# will execute on all workspaces on a given monitor.
# When I figure out how to join json data as precisely as database data I might
# improve this. Those can come in handy then:
# #
# focused_window=$(echo "$windows_metadata" | jq -r 'map(select(.focusHistoryID == 0)) | .[0]')
# focused_workspace=$(echo "$focused_window" | jq -r '.workspace.id')

if [ $(echo "$leftmost_address" | wc -l) -gt 1 ]; then
	IFS=$'\n' read -d '' -r -a address_array <<<"$leftmost_address"

	for address in "${address_array[@]}"; do
		hyprctl dispatch resizewindowpixel exact 49%,address:"$address"
	done
else
	echo $leftmost_address
	hyprctl dispatch resizewindowpixel exact 49%,address:"$leftmost_address"
fi
