#!/bin/bash
# For manually starting xdg-desktop-portal
start_portal() {
	local path=$1
	if [ -f "$path" ]; then
		echo "Starting $path"
		"$path" &
	else
		echo "Not found at location: $path"
	fi
}
sleep 1
killall -e xdg-desktop-portal-hyprland
killall -e xdg-desktop-portal-wlr
killall -e xdg-desktop-portal-gnome
killall -e xdg-desktop-portal-kde

killall xdg-desktop-portal
sleep 1
start_portal "/usr/lib/xdg-desktop-portal-hyprland"
start_portal "/usr/libexec/xdg-desktop-portal-hyprland"
sleep 2
start_portal "/usr/lib/xdg-desktop-portal-hyprland"
start_portal "/usr/libexec/xdg-desktop-portal"
sleep 2
systemctl --user start xdg-desktop-portal-hyprland.service
