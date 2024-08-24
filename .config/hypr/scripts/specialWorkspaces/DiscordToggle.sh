#!/bin/bash

#define ID of "special"
SPECIAL_WORKSPACE_NAME="special:discord"

# Grab clients as json
OUTPUT=$(hyprctl clients -j)
# Extract ferdium client data
DISCORD_OBJ=$(jq '.[] | select(.initialTitle == "Discord")' <<<"$OUTPUT")

# Guard clause, if no Spotify client, launch one and exit then place it on current workspace
if [ -z "$DISCORD_OBJ" ]; then
	echo "Launching Discord"
	firefoxpwa site launch 01J5XK92QZXQ6R2W9S2JP0CDF1 --protocol
	sleep 1
	hyprctl dispatch movetoworkspace "e-0","FFPWA-01J5XK92QZXQ6R2W9S2JP0CDF1"
	# hyprctl dispatch focuswindow "FFPWA-01J5XK92QZXQ6R2W9S2JP0CDF1"
	exit 0
fi

# Else grab the current workspace and the address ID of the client
CURRENT_DISCORD_WORKSPACE=$(jq -r '.workspace.name' <<<"$DISCORD_OBJ")
DISCORD_WINDOW_ADDR=$(jq -r '.address' <<<"$DISCORD_OBJ")

# If the window is on "special" then move it into view
if [ "$CURRENT_DISCORD_WORKSPACE" == "$SPECIAL_WORKSPACE_NAME" ]; then
	hyprctl dispatch movetoworkspace "e-0",address:"$DISCORD_WINDOW_ADDR"
	# hyprctl dispatch movewindowpixel 'exact 2062 46', address:"$DISCORD_WINDOW_ADDR"
	hyprctl dispatch focuswindow address:"$DISCORD_WINDOW_ADDR"
else
	# If not then by design it is in view, so send it away to "special"
	hyprctl dispatch movetoworkspacesilent special:discord,address:"$DISCORD_WINDOW_ADDR"
fi
echo "$DISCORD_WINDOW_ADDR"
exit 0
