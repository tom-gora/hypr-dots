#!/bin/env bash

# set -x

LOCKFILE="/tmp/special_workspace_toggle.lock"
if [ -e "$LOCKFILE" ]; then
	# Optionally, check if the PID inside the lock is still running.
	exit 0
fi
echo $$ >"$LOCKFILE"
trap 'rm -f "$LOCKFILE"' EXIT

# get the helpers
. "$HOME/.config/hypr/scripts/specialWorkspaces/__helpers.sh"

#declare ID of "special"
SPECIAL_WORKSPACE_NAME="$1"
QUERY_STRING="$(__toggle_set_query_string "$1")"

if [ -z "$QUERY_STRING" ] || [ "$QUERY_STRING" == "false" ]; then
	echo "Internal failure. Likely wrong arg passed."
	notify-send -u low -t 1000 "Internal failure. Likely wrong arg passed."
	exit 1
fi

# check against multiple instances due to lingering processess
PID="$(__toggle_get_win_params pid "$QUERY_STRING")"
pid_count=$(echo "$PID" | wc -l)

if [ "$pid_count" -gt 1 ]; then
	while IFS= read -r pid; do
		kill "$pid"
	done <<<"$PID"
fi

OBJ="$(__toggle_get_win_params object "$QUERY_STRING")"

# if not started, spawn appropriate process based on the $1 arg
if [ -z "$OBJ" ]; then
	case "$1" in
	scratchpad)
		SCRATCHPAD=1 wezterm start --always-new-process --class Scratchpad &
		exit 0
		;;
	spotify)
		flatpak run --command=brave com.brave.Browser --profile-directory=Default --app-id=pjibgclleladliembfgfagdaldikeohf --disable-gpu &
		exit 0
		;;
	discord)
		flatpak run --command=brave com.brave.Browser --profile-directory=Default --app-id=nebbmpibgobljecgkdipmcfonkkmcggn --disable-gpu &
		exit 0
		;;
	obsidian)
		flatpak run md.obsidian.Obsidian &
		exit 0
		;;
	thunderbird)
		thunderbird &
		exit 0
		;;
	ollama)
		flatpak run --command=brave com.brave.Browser --profile-directory=Default --app-id=lejoeijgcgldjekkomjapbnhhecipebo --disable-gpu &
		exit 0
		;;
	*)
		echo "false"
		exit 1
		;;
	esac &
	sleep 5

	# get win addr and if failed to start bail
	WINDOW_ADDR="$(__toggle_get_win_params address "$QUERY_STRING")"

	if [ -z "$WINDOW_ADDR" ] || [ "$WINDOW_ADDR" == "false" ]; then
		echo "Failed to spawn $(echo "$QUERY_STRING" | cut -d'%' -f2). Exiting"
		notify-send -u low -t 1000 "Failed to spawn $(echo "$QUERY_STRING" | cut -d'%' -f2). Exiting"
		exit 1
	fi
	# on successful start, move to current workspace and focus
	hyprctl dispatch movetoworkspacesilent e-0, address:"$WINDOW_ADDR"
	hyprctl dispatch focuswindow address:"$WINDOW_ADDR"
	exit 0
fi

#grab needed vars outside of guard clause
WINDOW_ADDR="$(__toggle_get_win_params address "$QUERY_STRING")"
CURRENT_WORKSPACE="$(__toggle_get_win_params workspace "$QUERY_STRING")"

if [ "$CURRENT_WORKSPACE" == "special:$SPECIAL_WORKSPACE_NAME" ]; then
	if [ "$1" == "ollama" ]; then
		hyprctl dispatch movetoworkspace 2, address:"$WINDOW_ADDR"
	else
		hyprctl dispatch movetoworkspace e-0, address:"$WINDOW_ADDR"
	fi
	hyprctl dispatch focuswindow address:"$WINDOW_ADDR"
else
	hyprctl dispatch movetoworkspacesilent special:"$SPECIAL_WORKSPACE_NAME", address:"$WINDOW_ADDR"
fi
exit 0
