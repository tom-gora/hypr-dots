#!/bin/bash

killall -e xdg-desktop-portal*
sleep 1
/usr/libexec/xdg-desktop-portal-hyprland &
sleep 2
/usr/libexec/xdg-desktop-portal-gtk &
sleep 2
/usr/libexec/xdg-desktop-portal &

# if [ -f /usr/libexec/xdg-desktop-portal-gtk ]; then
# 	/usr/libexec/xdg-desktop-portal-gtk &
# 	sleep 1
# fi
# sleep 1
# /usr/libexec/xdg-desktop-portal &
