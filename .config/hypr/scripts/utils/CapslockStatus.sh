#!/bin/env bash

status=$(cat /sys/class/leds/*capslock/brightness | head -n 1)

if [ "$status" == 1 ]; then
	echo -e "{\"text\": \"$status\", \"class\": \"locked\"}"
else
	echo -e "{\"text\": \"$status\", \"class\": \"unlocked\"}"
fi
