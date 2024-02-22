#!/bin/env bash

if pgrep -x "wf-recorder" >/dev/null; then
	pkill -INT -x wf-recorder
	notify-send -u low "Recording stopped."
	exit 0
fi
