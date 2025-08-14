#!/bin/env bash

ROFI_EXTRA_ARGS=(
	-theme-str 'textbox-prompt-icon {str: "  ";}'
	-theme-str 'entry { placeholder: "Clipboard..."; }'
)

if [[ ! $(pidof rofi) ]]; then
	cliphist list -preview-width 25 | rofi -dmenu "${ROFI_EXTRA_ARGS[@]}" | cliphist decode | wl-copy
else
	pkill rofi
fi
