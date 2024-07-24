#!/bin/bash

#define ID of "special"
SPECIAL_WORKSPACE_NAME="special:joplin"

# Grab clients as json
OUTPUT=$(hyprctl clients -j)
# Extract ferdium client data
JOPLIN_OBJ=$(jq '.[] | select(.initialTitle == "Joplin")' <<<"$OUTPUT")

# Guard clause, if no Spotify client, launch one and exit then place it on current workspace
if [ -z "$JOPLIN_OBJ" ]; then
  echo "Launching Joplin"
  ~/.local/bin/appimage/joplin/Joplin.AppImage
  hyprctl dispatch movetoworkspacesilent 'e-0','^(Joplin)$'
  hyprctl dispatch focuswindow '^(Joplin)$'
  exit 0
fi

# Else grab the current workspace and the address ID of the client
CURRENT_JOPLIN_WORKSPACE=$(jq -r '.workspace.name' <<<"$JOPLIN_OBJ")
JOPLIN_WINDOW_ADDR=$(jq -r '.address' <<<"$JOPLIN_OBJ")

# If the window is on "special" then move it into view
if [ "$CURRENT_JOPLIN_WORKSPACE" == "$SPECIAL_WORKSPACE_NAME" ]; then
  hyprctl dispatch movetoworkspace 'e-0',address:"$JOPLIN_WINDOW_ADDR"
  hyprctl dispatch focuswindow address:"$JOPLIN_WINDOW_ADDR"
else
  # If not then by design it is in view, so send it away to "special"
  hyprctl dispatch movetoworkspacesilent special:joplin,address:"$JOPLIN_WINDOW_ADDR"
fi
exit 0
