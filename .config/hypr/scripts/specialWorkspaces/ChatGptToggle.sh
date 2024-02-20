#!/bin/bash

set -x

#define ID of "special"
SPECIAL_WORKSPACE_NAME="special:chatgpt"

# Grab clients as json
OUTPUT=$(hyprctl clients -j)
# Extract ferdium client data
CGPT_OBJ=$(jq '.[] | select(.initialTitle == "ChatGPT")' <<<"$OUTPUT")

# Guard clause, if no Spotify client, launch one and exit then place it on current workspace
if [ -z "$CGPT_OBJ" ]; then
	echo "Launching Chat GPT"
	firefoxpwa site launch 01HMNRCK8N44H15ZX3C98E4KY9 --protocol
	sleep 1
	hyprctl dispatch movetoworkspace "2","FFPWA-01HMNRCK8N44H15ZX3C98E4KY9"
	hyprctl dispatch focuswindow "FFPWA-01HMNRCK8N44H15ZX3C98E4KY9"
	# hyprctl dispatch movewindowpixel exact 5062 46, "FFPWA-01HMNRCK8N44H15ZX3C98E4KY9"
	# hyprctl dispatch movewindow mon: current
	exit 0
fi

# Else grab the current workspace and the address ID of the client
CURRENT_CGPT_WORKSPACE=$(jq -r '.workspace.name' <<<"$CGPT_OBJ")
CGPT_WINDOW_ADDR=$(jq -r '.address' <<<"$CGPT_OBJ")

# If the window is on "special" then move it into view
if [ "$CURRENT_CGPT_WORKSPACE" == "$SPECIAL_WORKSPACE_NAME" ]; then
	hyprctl dispatch movetoworkspace "2",address:"$CGPT_WINDOW_ADDR"
	# hyprctl dispatch movewindowpixel 'exact 2062 46', address:"$CGPT_WINDOW_ADDR"
	hyprctl dispatch focuswindow address:"$CGPT_WINDOW_ADDR"
else
	# If not then by design it is in view, so send it away to "special"
	hyprctl dispatch movetoworkspacesilent special:chatgpt,address:"$CGPT_WINDOW_ADDR"
fi
echo $CURRENT_CGPT_WORKSPACE
exit 0
