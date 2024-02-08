#!/bin/bash

#define ID of "special"
SPECIAL_WORKSPACE_NAME="special:thunderbird"

set -x

# Grab clients as json
OUTPUT=$(hyprctl clients -j)
# Extract thunderbird client data
THUNDERBIRD_OBJ=$(jq '.[] | select(.initialTitle | test(".*Mozilla Thunderbird$"))' <<<"$OUTPUT")
echo $THUNDERBIRD_OBJ

# Guard clause, if no Thunderbird client, launch one and exit then place it on current workspace
if [ -z "$THUNDERBIRD_OBJ" ]; then
	echo "Launching Thunderbird"
	thunderbird &
	hyprctl dispatch movetoworkspace 'e-0','^(thunderbird)$'
	hyprctl dispatch focuswindow '^(thunderbird)$'
	exit 0
fi

# Else grab the current workspace and the address ID of the client
CURRENT_THUNDERBIRD_WORKSPACE=$(jq -r '.workspace.name' <<<"$THUNDERBIRD_OBJ")
THUNDERBIRD_WINDOW_ADDR=$(jq -r '.address' <<<"$THUNDERBIRD_OBJ")

# If the window is on "special" then move it into view
if [ "$CURRENT_THUNDERBIRD_WORKSPACE" == "$SPECIAL_WORKSPACE_NAME" ]; then
	hyprctl dispatch movetoworkspace 'e-0',address:"$THUNDERBIRD_WINDOW_ADDR"
	hyprctl dispatch focuswindow address:"$THUNDERBIRD_WINDOW_ADDR"
else
	# If not then by design it is in view, so send it away to "special"
	hyprctl dispatch movetoworkspacesilent special:thunderbird,address:"$THUNDERBIRD_WINDOW_ADDR"
fi
exit 0
