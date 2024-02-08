#!/bin/bash

notif="$HOME/.config/swaync/images/screenshot.png"
	
notify-send -u critical -i "$notif" "Make a Screenshot" "\[🇳\] Full Screenshot Now\n\[🇼\] Window Only Now\n\[🇦\] Area Screenshot\n\[🇸\] Full Screenshot Short Wait -5s\n\[🇱\] Full Screenshot Long Wait -10s\n\[🇪\] Editable Screenshot"

