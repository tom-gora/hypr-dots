#!/bin/bash
# Toggling calculator on and off with a single keybind

CALCULATOR_PROCESS="gnome-calendar"

if pkill -0 -f "$CALCULATOR_PROCESS"; then
	pkill -f "$CALCULATOR_PROCESS"
else
	gnome-calendar &
fi
