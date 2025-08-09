#!/bin/bash
# Rofi Clipboard Manager.
# Dependencies: cliphist, wl-copy and of course rofi

if [[ ! $(pidof rofi) ]]; then
	cliphist list -preview-width 25 | rofi -dmenu -theme-str 'textbox-prompt-icon {str: "  ";}' -theme-str 'entry { placeholder: "Clipboard..."; }' | cliphist decode | wl-copy
else
	pkill rofi
fi
