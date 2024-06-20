#!/bin/bash
# Toggling color picker on and off with a single keybind

if pgrep -f eyedropper; then
	pkill -f eyedropper
else
	flatpak run com.github.finefindus.eyedropper &
fi
