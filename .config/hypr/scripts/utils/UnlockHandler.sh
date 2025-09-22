#!/usr/bin/env bash

if playerctl status 2>/dev/null | grep -cq 'Paused'; then
	playerctl play -a
fi
