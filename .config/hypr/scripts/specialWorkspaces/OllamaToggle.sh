#!/bin/bash

#define ID of "special"
SPECIAL_WORKSPACE_NAME="special:ollama"

# Grab clients as json
OUTPUT=$(hyprctl clients -j)
# Extract ferdium client data
OLLAMA_OBJ=$(jq '.[] | select(.initialTitle == "Ollama Open WebUI")' <<<"$OUTPUT")

# Guard clause, if no Spotify client, launch one and exit then place it on current workspace
if [ -z "$OLLAMA_OBJ" ]; then
	echo "Launching Ollama Frontend UI"
	firefoxpwa site launch 01J4VCP1Y0M0HXJBSP8528JPKJ --protocol
	sleep 1
	hyprctl dispatch movetoworkspace "2","FFPWA-01J4VCP1Y0M0HXJBSP8528JPKJ"
	hyprctl dispatch focuswindow "FFPWA-01J4VCP1Y0M0HXJBSP8528JPKJ"
	# hyprctl dispatch movewindowpixel exact 5062 46, "FFPWA-01HMNRCK8N44H15ZX3C98E4KY9"
	# hyprctl dispatch movewindow mon: current
	exit 0
fi

# Else grab the current workspace and the address ID of the client
CURRENT_OLLAMA_WORKSPACE=$(jq -r '.workspace.name' <<<"$OLLAMA_OBJ")
OLLAMA_WINDOW_ADDR=$(jq -r '.address' <<<"$OLLAMA_OBJ")

# If the window is on "special" then move it into view
if [ "$CURRENT_OLLAMA_WORKSPACE" == "$SPECIAL_WORKSPACE_NAME" ]; then
	hyprctl dispatch movetoworkspace "2",address:"$OLLAMA_WINDOW_ADDR"
	# hyprctl dispatch movewindowpixel 'exact 2062 46', address:"$OLLAMA_WINDOW_ADDR"
	hyprctl dispatch focuswindow address:"$OLLAMA_WINDOW_ADDR"
else
	# If not then by design it is in view, so send it away to "special"
	hyprctl dispatch movetoworkspacesilent special:ollama,address:"$OLLAMA_WINDOW_ADDR"
fi
echo $OLLAMA_WINDOW_ADDR
exit 0
