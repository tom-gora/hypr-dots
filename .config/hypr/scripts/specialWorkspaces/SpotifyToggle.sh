#!/bin/bash

#define ID of "special"
SPECIAL_WORKSPACE_NAME="special:spotify"

# Grab clients as json
OUTPUT=$(hyprctl clients -j)
# Extract spotify client data
SPOTIFY_OBJ=$(jq '.[] | select(.initialTitle == "Spotify Premium")' <<<"$OUTPUT")

# Guard clause, if no Spotify client, launch one and exit then place it on current workspace
if [ -z "$SPOTIFY_OBJ" ]; then
	echo "Launching Spotify"
	flatpak run --socket=wayland com.spotify.Client --enable-features=WaylandWindowDecorations --ozone-platform-hint=auto &
	hyprctl dispatch movetoworkspace 'e-0','^(.*Spotify.*)$' &
	hyprctl dispatch focuswindow '^(.*Spotify.*)$' &
	exit 0
fi

# Else grab the current workspace and the address ID of the client
CURRENT_SPOTIFY_WORKSPACE=$(jq -r '.workspace.name' <<<"$SPOTIFY_OBJ")
SPOTIFY_WINDOW_ADDR=$(jq -r '.address' <<<"$SPOTIFY_OBJ")

# If the window is on "special" then move it into view
if [ "$CURRENT_SPOTIFY_WORKSPACE" == "$SPECIAL_WORKSPACE_NAME" ]; then
	hyprctl dispatch movetoworkspace 'e+0',address:"$SPOTIFY_WINDOW_ADDR"
	hyprctl dispatch focuswindow address:"$SPOTIFY_WINDOW_ADDR"
else
	# If not then by design it is in view, so send it away to "special"
	hyprctl dispatch movetoworkspacesilent special:spotify,address:"$SPOTIFY_WINDOW_ADDR"
fi
exit 0
