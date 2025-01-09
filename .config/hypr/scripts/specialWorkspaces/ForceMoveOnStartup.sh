#!/bin/bash

get_discord_pid() {
	OUTPUT=$(hyprctl clients -j)
	DISCORD_OBJ=$(jq '.[] | select(.initialClass == "FFPWA-01J4VCP1Y0M0HXJBSP8528JPKJ")' <<<"$OUTPUT")
	DISCORD_WINDOW_PID=$(jq -r '.pid' <<<"$DISCORD_OBJ")
	echo "$DISCORD_WINDOW_PID"
}

get_ollama_pid() {
	OUTPUT=$(hyprctl clients -j)
	OLLAMA_OBJ=$(jq '.[] | select(.initialClass == "FFPWA-01J4VCP1Y0M0HXJBSP8528JPKJ")' <<<"$OUTPUT")
	OLLAMA_WINDOW_PID=$(jq -r '.pid' <<<"$OLLAMA_OBJ")
	echo "$OLLAMA_WINDOW_PID"
}

get_thunderbird_pid() {
	OUTPUT=$(hyprctl clients -j)
	THUNDERBIRD_OBJ=$(jq '.[] | select(.initialClass == "org.mozilla.thunderbird")' <<<"$OUTPUT")
	THUNDERBIRD_WINDOW_PID=$(jq -r '.pid' <<<"$THUNDERBIRD_OBJ")
	echo "$THUNDERBIRD_WINDOW_PID"
}

get_spotify_pid() {
	OUTPUT=$(hyprctl clients -j)
	SPOTIFY_OBJ=$(jq '.[] | select(.initialTitle == "Spotify")' <<<"$OUTPUT")
	SPOTIFY_WINDOW_PID=$(jq -r '.pid' <<<"$SPOTIFY_OBJ")
	echo "$SPOTIFY_WINDOW_PID"
}

get_wezterm_addr() {
	OUTPUT=$(hyprctl clients -j)
	WEZTERM_OBJ=$(jq '.[] | select(.initialTitle == "wezterm")' <<<"$OUTPUT")
	WEZTERM_WINDOW_ADDR=$(jq -r '.address' <<<"$WEZTERM_OBJ")
	echo "$WEZTERM_WINDOW_ADDR"
}

DISCORD_MOVED=false
OLLAMA_MOVED=false
THUNDERBIRD_MOVED=false
SPOTIFY_MOVED=false

while ! $DISCORD_MOVED; do
	DISCORD_PID=$(get_discord_pid)
	if [ -n "$DISCORD_PID" ]; then
		echo "discord started with pid $DISCORD_PID"
		sleep 1
		hyprctl dispatch movetoworkspacesilent "e,pid:$DISCORD_PID"
		hyprctl dispatch movetoworkspacesilent "special:discord,pid:$DISCORD_PID"
		DISCORD_MOVED=true
	fi
done

while ! $OLLAMA_MOVED; do
	OLLAMA_PID=$(get_ollama_pid)
	if [ -n "$OLLAMA_PID" ]; then
		echo "ollama started with pid $OLLAMA_PID"
		sleep 1
		hyprctl dispatch movetoworkspacesilent "2,pid:$OLLAMA_PID"
		hyprctl dispatch movetoworkspacesilent "special:ollama,pid:$OLLAMA_PID"
		OLLAMA_MOVED=true
	fi
done

while ! $THUNDERBIRD_MOVED; do
	THUNDERBIRD_PID=$(get_thunderbird_pid)
	if [ -n "$THUNDERBIRD_PID" ]; then
		echo "Thunderbird started with pid $THUNDERBIRD_PID"
		sleep 1
		hyprctl dispatch movetoworkspacesilent "e,pid:$THUNDERBIRD_PID"
		hyprctl dispatch movetoworkspacesilent "special:thunderbird,pid:$THUNDERBIRD_PID"
		THUNDERBIRD_MOVED=true
	fi
done

while ! $SPOTIFY_MOVED; do
	SPOTIFY_PID=$(get_spotify_pid)
	if [ -n "$SPOTIFY_PID" ]; then
		echo "Spotify started with pid $SPOTIFY_PID"
		sleep 1
		hyprctl dispatch movetoworkspacesilent "e,pid:$SPOTIFY_PID"
		hyprctl dispatch movetoworkspacesilent "special:spotify,pid:$SPOTIFY_PID"
		SPOTIFY_MOVED=true
	fi
done

if $SPOTIFY_MOVED && $OLLAMA_MOVED && $THUNDERBIRD_MOVED; then
	break
fi

sleep 1
hyprctl dispatch "workspace 1"
sleep 1
hyprctl dispatch focuswindow "address:$(get_wezterm_addr)"
