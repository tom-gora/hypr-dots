#!/bin/env bash

# Kill any existing portal instances
killall xdg-desktop-portal-hyprland xdg-desktop-portal-gtk xdg-desktop-portal 2>/dev/null || true
sleep 1

# Set the correct environment
export XDG_CURRENT_DESKTOP=Hyprland:GNOME
export XDG_SESSION_TYPE=wayland

# Make sure systemd and dbus know about these variables
systemctl --user import-environment XDG_CURRENT_DESKTOP XDG_SESSION_TYPE
dbus-update-activation-environment --systemd XDG_CURRENT_DESKTOP XDG_SESSION_TYPE

# Give a moment for the environment to update
sleep 1

# Start the main portal service - it will automatically start the correct implementation
systemctl --user restart xdg-desktop-portal.service

# Wait for the main service to be fully up
sleep 2
