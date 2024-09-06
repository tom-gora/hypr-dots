#!/bin/env bash

icon="${HOME}/.config/swaync/images/record.svg"

if pgrep -x "wf-recorder" >/dev/null; then
	pkill -INT -x wf-recorder
	notify-send -u low -i "$icon" "Recording stopped."
	exit 0
fi
