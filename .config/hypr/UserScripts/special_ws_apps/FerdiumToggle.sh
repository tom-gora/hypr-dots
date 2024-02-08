#!/bin/bash

#define ID of "special"
SPECIAL_WORKSPACE_NAME="special:ferdium"

# Grab clients as json
OUTPUT=$(hyprctl clients -j)
# Extract ferdium client data
FERDIUM_OBJ=$(jq '.[] | select(.initialTitle == "Ferdium")' <<<"$OUTPUT")

# Guard clause, if no Spotify client, launch one and exit then place it on current workspace
if [ -z "$FERDIUM_OBJ" ]; then
	echo "Launching Ferdium"
	flatpak run org.ferdium.Ferdium %U
	hyprctl dispatch movetoworkspacesilent 'e-0','^(Ferdium)$'
	hyprctl dispatch focuswindow '^(Ferdium)$'
	exit 0
fi

# Else grab the current workspace and the address ID of the client
CURRENT_FERDIUM_WORKSPACE=$(jq -r '.workspace.name' <<<"$FERDIUM_OBJ")
FERDIUM_WINDOW_ADDR=$(jq -r '.address' <<<"$FERDIUM_OBJ")

# If the window is on "special" then move it into view
if [ "$CURRENT_FERDIUM_WORKSPACE" == "$SPECIAL_WORKSPACE_NAME" ]; then
	hyprctl dispatch movetoworkspace 'e-0',address:"$FERDIUM_WINDOW_ADDR"
	hyprctl dispatch focuswindow address:"$FERDIUM_WINDOW_ADDR"
else
	# If not then by design it is in view, so send it away to "special"
	hyprctl dispatch movetoworkspacesilent special:ferdium,address:"$FERDIUM_WINDOW_ADDR"
fi
exit 0
