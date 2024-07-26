#!/bin/bash

get_spotify_pid() {
	OUTPUT=$(hyprctl clients -j)
	SPOTIFY_OBJ=$(jq '.[] | select(.initialTitle == "Spotify Premium")' <<<"$OUTPUT")
	SPOTIFY_WINDOW_PID=$(jq -r '.pid' <<<"$SPOTIFY_OBJ")
	echo $SPOTIFY_WINDOW_PID
}

get_ckb_pid() {
	OUTPUT=$(hyprctl clients -j)
	CKB_OBJ=$(jq '.[] | select(.initialClass == "ckb-next")' <<<"$OUTPUT")
	CKB_WINDOW_PID=$(jq -r '.pid' <<<"$CKB_OBJ")
	echo $CKB_WINDOW_PID
}

SPOTIFY_MOVED=false
CKB_MOVED=false

while true; do
	if ! $SPOTIFY_MOVED; then
		SPOTIFY_PID=$(get_spotify_pid)
		if [ -n "$SPOTIFY_PID" ]; then
			echo "Spotify started with pid $SPOTIFY_PID"
			hyprctl dispatch movetoworkspacesilent "1,pid:$SPOTIFY_PID"
			hyprctl dispatch movetoworkspacesilent "special:spotify,pid:$SPOTIFY_PID"
			SPOTIFY_MOVED=true
		fi
	fi

	if ! $CKB_MOVED; then
		CKB_PID=$(get_ckb_pid)
		if [ -n "$CKB_PID" ]; then
			echo "ckb-next started with pid $CKB_PID"
			hyprctl dispatch movetoworkspacesilent "1,pid:$CKB_PID"
			hyprctl dispatch movetoworkspacesilent "special:ckb-next,pid:$CKB_PID"
			CKB_MOVED=true
		fi
	fi

	if $SPOTIFY_MOVED && $CKB_MOVED; then
		break
	fi

	sleep 1
done
