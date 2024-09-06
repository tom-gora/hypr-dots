#!/bin/bash

# get_spotify_pid() {
# 	OUTPUT=$(hyprctl clients -j)
# 	SPOTIFY_OBJ=$(jq '.[] | select(.initialTitle == "Spotify Premium")' <<<"$OUTPUT")
# 	SPOTIFY_WINDOW_PID=$(jq -r '.pid' <<<"$SPOTIFY_OBJ")
# 	echo $SPOTIFY_WINDOW_PID
# }

get_ckb_pid() {
	OUTPUT=$(hyprctl clients -j)
	CKB_OBJ=$(jq '.[] | select(.initialClass == "ckb-next")' <<<"$OUTPUT")
	CKB_WINDOW_PID=$(jq -r '.pid' <<<"$CKB_OBJ")
	echo $CKB_WINDOW_PID
}

get_ollama_pid() {
	OUTPUT=$(hyprctl clients -j)
	OLLAMA_OBJ=$(jq '.[] | select(.initialClass == "FFPWA-01J4VCP1Y0M0HXJBSP8528JPKJ")' <<<"$OUTPUT")
	OLLAMA_WINDOW_PID=$(jq -r '.pid' <<<"$OLLAMA_OBJ")
	echo $OLLAMA_WINDOW_PID
}

get_thunderbird_pid() {
	OUTPUT=$(hyprctl clients -j)
	THUNDERBIRD_OBJ=$(jq '.[] | select(.initialClass == "org.mozilla.thunderbird")' <<<"$OUTPUT")
	THUNDERBIRD_WINDOW_PID=$(jq -r '.pid' <<<"$THUNDERBIRD_OBJ")
	echo $THUNDERBIRD_WINDOW_PID
}

# SPOTIFY_MOVED=false
CKB_MOVED=false
OLLAMA_MOVED=false
THUNDERBIRD_MOVED=false

while true; do
	if ! $CKB_MOVED; then
		CKB_PID=$(get_ckb_pid)
		if [ -n "$CKB_PID" ]; then
			echo "ckb-next started with pid $CKB_PID"
			sleep 1
			hyprctl dispatch movetoworkspacesilent "e,pid:$CKB_PID"
			hyprctl dispatch movetoworkspacesilent "special:ckb-next,pid:$CKB_PID"
			CKB_MOVED=true
		fi
	fi

	if ! $OLLAMA_MOVED; then
		OLLAMA_PID=$(get_ollama_pid)
		if [ -n "$OLLAMA_PID" ]; then
			echo "ollama started with pid $OLLAMA_PID"
			sleep 1
			hyprctl dispatch movetoworkspacesilent "2,pid:$OLLAMA_PID"
			hyprctl dispatch movetoworkspacesilent "special:ollama,pid:$OLLAMA_PID"
			OLLAMA_MOVED=true
		fi
	fi

	# if ! $SPOTIFY_MOVED; then
	# 	SPOTIFY_PID=$(get_spotify_pid)
	# 	if [ -n "$SPOTIFY_PID" ]; then
	# 		echo "Spotify started with pid $SPOTIFY_PID"
	# 		sleep 1
	# 		hyprctl dispatch movetoworkspacesilent "e,pid:$SPOTIFY_PID"
	# 		hyprctl dispatch movetoworkspacesilent "special:spotify,pid:$SPOTIFY_PID"
	# 		SPOTIFY_MOVED=true
	# 	fi
	# fi

	if ! $THUNDERBIRD_MOVED; then
		THUNDERBIRD_PID=$(get_thunderbird_pid)
		if [ -n "$THUNDERBIRD_PID" ]; then
			echo "Thunderbird started with pid $THUNDERBIRD_PID"
			sleep 1
			hyprctl dispatch movetoworkspacesilent "e,pid:$THUNDERBIRD_PID"
			hyprctl dispatch movetoworkspacesilent "special:thunderbird,pid:$THUNDERBIRD_PID"
			THUNDERBIRD_MOVED=true
		fi
	fi

	if $SPOTIFY_MOVED && $CKB_MOVED && $OLLAMA_MOVED && $THUNDERBIRD_MOVED; then
		break
	fi

	sleep 1
	hyprctl dispatch "workspace 1"
done
