#!/bin/bash

sleep 1
killall xdg-desktop-portal-hyprland
killall xdg-desktop-portal-wlr
killall xdg-desktop-portal-gnome
killall xdg-desktop-portal
sleep 1
/usr/libexec/xdg-desktop-portal-hyprland &

if [ -f /usr/libexec/xdg-desktop-portal-gtk ]; then
	/usr/libexec/xdg-desktop-portal-gtk &
	sleep 1
fi
sleep 1
/usr/libexec/xdg-desktop-portal &
