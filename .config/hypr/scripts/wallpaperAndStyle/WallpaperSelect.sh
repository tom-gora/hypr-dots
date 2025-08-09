#!/bin/bash
# This script for selecting wallpapers (SUPER W)

SCRIPTSDIR="$HOME/.config/hypr/scripts"

# WALLPAPERS PATH
wallDIR="$HOME/.config/hypr-wallpapers"

# Retrieve image files
PICS=($(ls "${wallDIR}" | grep -E ".jpg$|.jpeg$|.png$|.gif$"))

# Rofi command
rofi_command="rofi -show -dmenu -config ~/.config/rofi/config-wallpaper.rasi"

menu() {
	for i in "${!PICS[@]}"; do
		# Displaying .gif to indicate animated images
		if [[ -z $(echo "${PICS[$i]}" | grep .gif$) ]]; then
			printf "$(echo "${PICS[$i]}" | cut -d. -f1)\x00icon\x1f${wallDIR}/${PICS[$i]}\n"
		else
			printf "${PICS[$i]}\n"
		fi
	done
}

main() {
	choice=$(menu | ${rofi_command})

	# No choice case
	if [[ -z $choice ]]; then
		exit 0
	fi

	# Find the index of the selected file
	pic_index=-1
	for i in "${!PICS[@]}"; do
		filename=$(basename "${PICS[$i]}")
		if [[ "$filename" == "$choice"* ]]; then
			pic_index=$i
			break
		fi
	done

	#reuse updater designed to be walker backend
	if [[ $pic_index -ne -1 ]]; then
		local UPDATER
		UPDATER="$(readlink -f "$(dirname "$0")")/Update.sh -i $wallDIR/$choice.png"
		$UPDATER
	else
		echo "Image not found."
		exit 1
	fi
}

main
