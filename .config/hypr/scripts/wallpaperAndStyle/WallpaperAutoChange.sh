#!/usr/bin/env bash

UPDATE_SCRIPT="$HOME/.config/hypr/scripts/wallpaperAndStyle/Update.sh -d $HOME/.config/hypr-wallpapers/"

export SWWW_TRANSITION_FPS=60
export SWWW_TRANSITION_TYPE=simple

MINUTES=15
INTERVAL=$((MINUTES * 60))

while true; do
	sleep "$INTERVAL"
	# safely call updater
	systemd-inhibit --what=shutdown:sleep:handle-power-key --who="Wallust Updater" --why="Updating theme dotfiles" "$UPDATE_SCRIPT" >/dev/null 2>&1
done
