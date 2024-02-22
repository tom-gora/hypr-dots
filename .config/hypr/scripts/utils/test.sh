#!/bin/env bash

wf-recorder_check() {
	if pgrep -x "wf-recorder" >/dev/null; then
		pkill -INT -x wf-recorder
		notify-send "Stopping all instances of wf-recorder" "$(cat /tmp/recording.txt)"
		wl-copy <"$(cat /tmp/recording.txt)"
		exit 0
	fi
}

wf-recorder_check

SELECTION=$(echo -e "record selection\nrecord DP-1\nrecord DP-2" | fuzzel -d -p "󰄀 " -w 25 -l 6)

VID="${HOME}/Videos/Recordings/$(date +%Y-%m-%d_%H-%m-%s).mp4"

case "$SELECTION" in
"record selection")
	echo "$VID" >/tmp/recording.txt
	wf-recorder -a -g "$(slurp)" -f "$VID" &>/dev/null
	;;
"record left")
	echo "$VID" >/tmp/recording.txt
	wf-recorder -a -o DP-1 -f "$VID" &>/dev/null
	;;
"record right")
	echo "$VID" >/tmp/recording.txt
	wf-recorder -a -o HDMI-A-1 -f "$VID" &>/dev/null
	;;
*) ;;
esac
