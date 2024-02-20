#!/bin/bash

#set -x

# Get a random image file from the background image folder.
IMAGE_FILE=$(/usr/bin/find -L /usr/share/sddm/themes/simple-sddm/hook-into-system-wallpapers -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.gif" \) | shuf -n 1)

echo "$IMAGE_FILE" > /tmp/initial-wallpaper

# Set proper perms
chown tomeczku:root /tmp/initial-wallpaper

# Get the path to the sddm theme folder.
SDDM_THEME_FOLDER="/usr/share/sddm/themes/simple-sddm"

# Create a symbolic link to the random image file in the sddm theme folder (overwrite with the force flag).
cp -f "$IMAGE_FILE" "$SDDM_THEME_FOLDER/background.jpg"

