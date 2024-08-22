#!/bin/bash

#set -x

# Get a random image file from the background image folder.
IMAGE_FILE=$(/usr/bin/find -L /usr/share/sddm/themes/simple-sddm/hook-into-system-wallpapers -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.gif" \) | shuf -n 1)
IMAGE_STATE_CONFIRM="/tmp/initial-wallpaper"

echo "$IMAGE_FILE" >"$IMAGE_STATE_CONFIRM"

# Get the path to the sddm theme folder.
SDDM_THEME_FOLDER="/usr/share/sddm/themes/simple-sddm"

# Set proper perms
chown tomeczku:root "$IMAGE_STATE_CONFIRM"

# Create a symbolic link to the random image file in the sddm theme folder (overwrite with the force flag).
cp -f "$IMAGE_FILE" "$SDDM_THEME_FOLDER/background.jpg"
