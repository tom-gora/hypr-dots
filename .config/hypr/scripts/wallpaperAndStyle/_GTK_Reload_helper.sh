#!/bin/env bash

# GTK3

current_theme=$(gsettings get org.gnome.desktop.interface gtk-theme)
# quick adwaita, in and out.
gsettings set org.gnome.desktop.interface gtk-theme ''
gsettings set org.gnome.desktop.interface gtk-theme "$current_theme"
gsettings set org.gnome.desktop.interface ''
gsettings set org.gnome.desktop.interface "$current_theme"

# what do for GTK4???
#
# if ps aux | grep -q "gnome-calendar"; then
# 	killall gnome-calendar && gnome-calendar &
# fi
