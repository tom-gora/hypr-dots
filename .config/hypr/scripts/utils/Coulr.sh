#!/bin/bash
# Toggling color picker on and off with a single keybind

if pgrep -f coulr; then
	pkill -f coulr
else
	flatpak run com.github.huluti.Coulr &
fi
