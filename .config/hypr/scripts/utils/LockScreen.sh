#!/bin/bash
# For Swaylock

CONFIG="$HOME/.config/swaylock/config"

sleep 0.5s
swaylock --config ${CONFIG} &
disown
