#!/bin/bash

CALCULATOR_PROCESS="gnome-calculator"

if pkill -0 -f "$CALCULATOR_PROCESS"; then
	pkill -f "$CALCULATOR_PROCESS"
else
	gnome-calculator &
fi
