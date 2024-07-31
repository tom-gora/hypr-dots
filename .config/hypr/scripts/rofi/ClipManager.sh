#!/bin/bash
# Rofi Clipboard Manager.
# Dependencies: cliphist, wl-copy and of course rofi

if [[ ! $(pidof rofi) ]]; then
	cliphist list | rofi -dmenu -config ~/.config/rofi/config-cliphist.rasi | cliphist decode | wl-copy
else
	pkill rofi
fi
