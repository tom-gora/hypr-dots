#!/usr/bin/env bash

# if called with unlock arg check if there were players paused by this script (not by user) and unpause
if [[ "$1" == "unlock" ]]; then
	if playerctl status 2>/dev/null | grep -cq 'Paused' && [[ -f /tmp/.paused_by_lock_handler ]]; then
		playerctl play -a
		# remove lock
		rm /tmp/.paused_by_lock_handler
		exit 0
	fi
	exit 0
fi

# if called "bare" just pause if playing + set the lock then exec hyprlock
if playerctl status 2>/dev/null | grep -cq 'Playing'; then
	playerctl pause -a
	# set lock
	touch /tmp/.paused_by_lock_handler
fi
sleep 0.5
pidof hyprlock || hyprlock
