#!/bin/env bash

get_ollama_pid() {
	OUTPUT=$(hyprctl clients -j)
	OLLAMA_OBJ=$(jq '.[] | select(.initialClass == "FFPWA-01J4VCP1Y0M0HXJBSP8528JPKJ")' <<<"$OUTPUT")
	OLLAMA_WINDOW_PID=$(jq -r '.pid' <<<"$OLLAMA_OBJ")
	echo "$OLLAMA_WINDOW_PID"
}

get_thunderbird_pid() {
	OUTPUT=$(hyprctl clients -j)
	THUNDERBIRD_OBJ=$(jq '.[] | select(.initialClass | test("thunderbird"))' <<<"$OUTPUT")
	THUNDERBIRD_WINDOW_PID=$(jq -r '.pid' <<<"$THUNDERBIRD_OBJ")
	echo "$THUNDERBIRD_WINDOW_PID"
}

OLLAMA_RUNNING=false
THUNDERBIRD_RUNNING=false

while ! $OLLAMA_RUNNING; do
	OLLAMA_PID=$(get_ollama_pid)
	if [ -n "$OLLAMA_PID" ]; then
		OLLAMA_RUNNING=true
	fi
done

while ! $THUNDERBIRD_RUNNING; do
	THUNDERBIRD_PID=$(get_thunderbird_pid)
	if [ -n "$THUNDERBIRD_PID" ]; then
		THUNDERBIRD_RUNNING=true
	fi
done

if $OLLAMA_RUNNING && $THUNDERBIRD_RUNNING; then
	sleep 1
	hyprctl dispatch "workspace 2"
	sleep 1
	hyprctl dispatch "workspace 1"
fi
