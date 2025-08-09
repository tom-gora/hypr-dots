#!/bin/bash

DIR_PATH=""
IMG_PATH=""
TRANSITIONS=1

usage() {
	echo "Usage: $0 [OPTIONS]"
	echo "This script sets a new wallpaper and updates the environment based on it."
	echo ""
	echo "Options:"
	echo "  -d, --dir <path>    Path to a directory containing images."
	echo "  -i, --img <path>    Path to a specific image file."
	echo "  -n, --no-transition Apply wallpaper without transition effects."
	echo "  -h, --help          Display this help message and exit."
	echo ""
	echo "Note: Either -d or -i must be provided, but not both."
	exit 1
}

check_args() {
	local has_dir=false
	local has_img=false

	while [[ "$#" -gt 0 ]]; do
		case "$1" in
		-h | --help)
			usage
			exit 1
			;;
		-d | --dir)
			if [[ -z "$2" ]]; then
				echo "Error: Option '$1' requires an argument." >&2
				usage
				exit 1
			fi
			DIR_PATH="$2"
			has_dir=true
			shift
			;;
		-i | --img)
			if [[ -z "$2" ]]; then
				echo "Error: Option '$1' requires an argument." >&2
				usage
				exit 1
			fi
			IMG_PATH="$2"
			has_img=true
			shift
			;;
		-n | --no-transition)
			TRANSITIONS=0
			;;
		*)
			echo "Error: Unknown option '$1'" >&2
			usage
			exit 1
			;;
		esac
		shift
	done

	# Check for mutual exclusivity and presence of -d or -i
	if $has_dir && $has_img; then
		echo "Error: Both -d (--dir) and -i (--img) cannot be provided simultaneously." >&2
		usage
		exit 1
	elif ! $has_dir && ! $has_img; then
		echo "Error: Either -d (--dir) or -i (--img) must be provided." >&2
		usage
		exit 1
	fi
}

get_random_image_from_dir() {
	local wallDIR="$1"

	if [[ ! -d "$wallDIR" ]]; then
		echo "Error: '$wallDIR' is not a valid directory." >&2
		return 1
	fi

	local PICS=()
	while IFS= read -r -d $'\0' file; do
		PICS+=("$file")
	done < <(find -L "$wallDIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" \) -print0)

	if [[ ${#PICS[@]} -eq 0 ]]; then
		echo "No image files found in '$wallDIR'." >&2
		return 1
	fi

	local random_index=$((RANDOM % ${#PICS[@]}))
	local selected_image="${PICS[$random_index]}"

	echo "$selected_image"
	return 0
}

set_wallpaper() {
	# Transition config
	FPS=60
	TYPE="any"
	DURATION=0.5
	BEZIER=".43,1.19,1,.4"
	SWWW_PARAMS="--transition-fps $FPS --transition-type $TYPE --transition-duration $DURATION --transition-bezier $BEZIER"

	swww query >/dev/null
	if [ $? -eq 1 ]; then
		swww-daemon
	fi
	swww img "$1" "$SWWW_PARAMS"
}

store_cached_img() {
	local SWWW_CACHE_DIR="$HOME/.cache/swww/"
	local MONITOR_OUTPUTS=()
	local CACHE_FILE=""
	local WALLPAPER_PATH="$1"
	local DEST_PATH="$HOME/.cache/.current_wallpaper"

	if [[ ! -d "$SWWW_CACHE_DIR" ]]; then
		return 1
	fi

	mapfile -t MONITOR_OUTPUTS < <(find "$SWWW_CACHE_DIR" -maxdepth 1 -mindepth 1 -printf '%f\n')

	if [[ ${#MONITOR_OUTPUTS[@]} -eq 0 ]]; then
		return 1
	fi

	for OUTPUT in "${MONITOR_OUTPUTS[@]}"; do
		CACHE_FILE="$SWWW_CACHE_DIR/$OUTPUT"

		if [[ -f "$CACHE_FILE" ]]; then
			WALLPAPER_PATH=$(grep -v 'Lanczos3' "$CACHE_FILE" | head -n 1)

			if [[ -z "$WALLPAPER_PATH" ]]; then
				continue
			fi

			if ln -sf "$WALLPAPER_PATH" "$DEST_PATH"; then
				return 0
			else
				echo "Error: Failed to create symlink for '$WALLPAPER_PATH' to '$DEST_PATH'" >&2
			fi
		fi
	done
	return 1
}

call_swww() {
	local IMG="$1"

	if [[ -z "$IMG" ]]; then
		echo "Error: No image provided to swww."
		return 1
	fi

	local SWWW_PARAMS="--transition-type none"
	if [[ "$TRANSITIONS" -ne 0 ]]; then
		FPS=60
		TYPE="any"
		DURATION=0.5
		BEZIER=".43,1.19,1,.4"
		SWWW_PARAMS="--transition-fps $FPS --transition-type $TYPE --transition-duration $DURATION --transition-bezier $BEZIER"
	fi

	swww-daemon
	swww query
	swww img "$IMG" $SWWW_PARAMS
	if [[ $? -ne 0 ]]; then
		echo "Error: Failed to set wallpaper with swww."
		return 1
	fi

	return 0
}

post_wallust_reload() {
	killall rofi
	killall walker

	swaync-client -rs

	# handle GTK
	local GTK_RELOAD_HELPER
	GTK_RELOAD_HELPER="$(readlink -f "$(dirname "$0")")/_GTK_Reload_helper.sh"
	$GTK_RELOAD_HELPER

	# handle waybar
	local WAYBAR_STYLES_FILE="$HOME/.config/waybar/style.css"

	if [ ! -f "$WAYBAR_STYLES_FILE" ]; then
		echo "Error: File not found at $WAYBAR_STYLES_FILE"
		pkill waybar
		sleep 1
		waybar &
	fi

	local CURRENT_CONTENT
	CURRENT_CONTENT=$(<"$WAYBAR_STYLES_FILE")
	printf "%s" "$CURRENT_CONTENT" >"$WAYBAR_STYLES_FILE"
	if [ $? -ne 0 ]; then
		echo "Error: Failed trigger waybar's hot reload."
	fi

	# handle tmux
	local TMUX_CONFIG_FILE="$HOME/.config/tmux/tmux.conf"
	tmux source-file "$TMUX_CONFIG_FILE"

	# handle oh-my-posh
	local WALLUST_OMP_PALETTE_FILE="$HOME/.cache/wallust/targets/omp.json"
	local OMP_CONFIG_FILE="$HOME/.config/my_omp.json"

	if [[ ! -f "$WALLUST_OMP_PALETTE_FILE" ]]; then
		echo "Error: New Oh My Posh palette file not found at $WALLUST_OMP_PALETTE_FILE." >&2
	fi

	if [[ ! -f "$OMP_CONFIG_FILE" ]]; then
		echo "Error: Oh My Posh config file not found at $OMP_CONFIG_FILE." >&2
	fi

	local NEW_PALETTE_CONTENT NEW_CONFIG_CONTENT
	NEW_PALETTE_CONTENT=$(<"$WALLUST_OMP_PALETTE_FILE")

	NEW_CONFIG_CONTENT=$(jq --argjson new_palette "$NEW_PALETTE_CONTENT" '.palette = $new_palette' "$OMP_CONFIG_FILE")
	echo "$NEW_CONFIG_CONTENT" >"$OMP_CONFIG_FILE"
	if [ $? -ne 0 ]; then
		echo "Error: Failed to update Oh My Posh config file with jq." >&2
	fi

	# handle swaync
	swaync-client --reload-css

	# handle obsidian
	local OBSIDIAN_RELOAD_HELPER
	OBSIDIAN_RELOAD_HELPER="$(readlink -f "$(dirname "$0")")/_Obsidian_Reload_helper.js"
	$OBSIDIAN_RELOAD_HELPER

}

main() {
	check_args "$@"
	if [[ -n "$DIR_PATH" ]]; then
		IMG=$(get_random_image_from_dir "$DIR_PATH")
		local IS_IMG="$?"
		if [[ "$IS_IMG" -eq 1 ]]; then
			echo "Error: Failed to get a random image from directory '$DIR_PATH'."
			exit 1
		fi
	elif [[ -n "$IMG_PATH" ]]; then
		IMG="$IMG_PATH"
		local IS_IMG="$?"
		if [[ "$IS_IMG" -eq 1 ]]; then
			echo "Error: Failed to stat the image file '$IMG_PATH'."
			exit 1
		fi
	fi
	echo "Successfully got image to be applied: $IMG"
	call_swww "$IMG"
	local RC="$?"
	if [[ "$RC" -eq 1 ]]; then
		echo "Error: Failed to set wallpaper with swww."
		exit 1
	fi
	echo "Successfully set wallpaper with swww."

	store_cached_img "$IMG"
	RC="$?"
	if [[ "$RC" -eq 1 ]]; then
		echo "Error: Failed to store cached image."
		exit 1
	fi
	echo "Successfully stored cached image."
	echo "Updating the colors now..."

	"$HOME/.config/cargo/bin/wallust" run "$IMG" -s
	post_wallust_reload
	RC="$?"
	if [[ "$RC" -eq 1 ]]; then
		echo "Error: Failed to at reloading the environment after setting wallpaper."
		exit 1
	fi
	exit 0
}

main "$@"
