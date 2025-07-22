#!/bin/bash

UPDATE_SCRIPT="$HOME/.config/hypr/scripts/wallpaperAndStyle/Update.sh -d $HOME/.config/hypr-wallpapers/"

if [[ $# -lt 1 ]] || [[ ! -d $1 ]]; then
	echo "Usage:
	$0 <dir containing images>"
	exit 1
fi

# Edit below to control the images transition

export SWWW_TRANSITION_FPS=60
export SWWW_TRANSITION_TYPE=simple

# This controls (in seconds) when to switch to the next image
INTERVAL=900

while true; do
	sleep "$INTERVAL"
	$UPDATE_SCRIPT
done
