#!/bin/bash

#define ID of "special"
SPECIAL_WORKSPACE_NAME="special:scratchpad"

# Grab clients as json
OUTPUT=$(hyprctl clients -j)
# Extract ferdium client data
SCRATCHPAD_OBJ=$(jq '.[] | select(.class == "Scratchpad")' <<<"$OUTPUT")

# Guard clause, if no Spotify client, launch one and exit then place it on current workspace
if [ -z "$SCRATCHPAD_OBJ" ]; then
	echo "Launching Kitty Scratchpad"
	SCRATCHPAD=1 kitty --single-instance -T Scratchpad --class Scratchpad &

	sleep 1
	hyprctl dispatch movetoworkspacesilent "e-0","^(.*Scratchpad.*)$"
	hyprctl dispatch focuswindow '^(.*Scratchpad.*)$'
	exit 0
fi

# Else grab the current workspace and the address ID of the client
CURRENT_SCRATCHPAD_WORKSPACE=$(jq -r '.workspace.name' <<<"$SCRATCHPAD_OBJ")
SCRATCHPAD_WINDOW_ADDR=$(jq -r '.address' <<<"$SCRATCHPAD_OBJ")

# If the window is on "special" then move it into view
if [ "$CURRENT_SCRATCHPAD_WORKSPACE" == "$SPECIAL_WORKSPACE_NAME" ]; then
	hyprctl dispatch movetoworkspace 'e-0',address:"$SCRATCHPAD_WINDOW_ADDR"
	hyprctl dispatch focuswindow address:"$SCRATCHPAD_WINDOW_ADDR"
else
	# If not then by design it is in view, so send it away to "special"
	hyprctl dispatch movetoworkspacesilent special:scratchpad,address:"$SCRATCHPAD_WINDOW_ADDR"
fi
exit 0
