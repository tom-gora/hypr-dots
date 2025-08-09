#!/bin/bash

# Rofi menu for color shades

NOTI_IMG="$HOME/.config/swaync/images/rofi-error.svg"

# rudimentary check if deps availavble on the system
check_deps() {
	local PASTEL
	PASTEL=$(which pastel)
	local HYPRPICKER
	HYPRPICKER=$(which hyprpicker)
	local MISSING_DEPS=()

	if [[ -z "$PASTEL" ]]; then
		MISSING_DEPS+=("pastel")
	fi
	if [[ -z "$HYPRPICKER" ]]; then
		MISSING_DEPS+=("hyprpicker")
	fi

	if [[ ${#MISSING_DEPS[@]} -ne 0 ]]; then
		notify-send -t 4000 -i "$NOTI_IMG" "Rofi Error" "Dependencies not found: \
    ${MISSING_DEPS[*]} \
    Please install them first."
		exit 1
	fi
}

# final check helper to make sure value is a valid hex color
final_validate_color_from_pastel() {
	local VAL="$1"
	[[ "$VAL" =~ ^#[0-9A-Fa-f]{3,8}$ ]]
}

main() {
	# check if any input color is in the clipboard
	# if it is a color pastel will be able to process it else exit with 1
	SOURCE_COLOR="$(wl-paste)"
	pastel color "$SOURCE_COLOR" >/dev/null 2>&1
	EXIT_CODE=$?

	# if color not in a clipboard fire up a picker tool
	if [[ $EXIT_CODE -ne 0 ]]; then
		#hyprpick color
		PICKER_RESULT=$(hyprpicker -r --format hex 2>&1)
		# hyprpicker might return additional errors. extract the hex color line only
		SOURCE_COLOR=$(echo "$PICKER_RESULT" | grep -i '^#[a-f0-9]\+$')
	fi

	IS_ERR=$(echo "$SOURCE_COLOR" | wc -l)
	notify-send "$IS_ERR"
	# get gradient breakdown from pastel going from input color
	# towards both black and white. then remove both of those as they are not really needed
	# and also remove input colot from one of the blocks to not have it repeated twice when
	# "arrays" are put together
	FROM_DARK=$(pastel gradient --number=12 000000 "$SOURCE_COLOR" | pastel format hex | sed '1d;$d')
	INTO_LIGHT=$(pastel gradient --number=12 "$SOURCE_COLOR" ffffff | pastel format hex | sed '$d')
	# join the two blocks together
	FULL_GRADIENT_LIST=$(echo -e "$FROM_DARK\n""$INTO_LIGHT")
	declare -a TEMPLATE

	# indexing to help both chosing from rofi list by typing in index
	# as well as to memorize the selected color
	# in case selecting from the same list later to easie allow to select the same
	# or another in relation to the index
	LINE_INDEX=0

	# read prepared colors
	while IFS= read -r line; do

		# check to throw and exit if any input values are invalid as final safeguard
		# (may happen i.e. when interruped picker and pastel received invalid input.)
		if ! final_validate_color_from_pastel "$line"; then
			notify-send -t 4000 -i "$NOTI_IMG" "Rofi Error" "Invalid color value encountered. Try again."
			exit 1
		fi
		# interpolate color hex code into predefined lines of pango markup
		# slightly highlighting the input color with subtle bg with opacity
		if [[ ${line^^} == "${SOURCE_COLOR^^}" ]]; then
			TEMPLATED_LINE="<span size='16pt' rise='4pt' fgcolor='$line'>■   </span> <span>$line</span>"
		else
			TEMPLATED_LINE="<span size='16pt' rise='4pt' fgcolor='$line'>■   </span><span>$line</span>"
		fi
		# append markup lines and store as arr
		TEMPLATE+=("$TEMPLATED_LINE")
	done <<<"$FULL_GRADIENT_LIST"

	# prep line separated output for rofi to consume
	MARKUP=$(printf "%s\n" "${TEMPLATE[@]}")
	# get selection from rofi picker
	CHOICE=$(echo "$MARKUP" | rofi -dmenu -markup-rows -theme-str 'entry { enabled: false;}' -theme-str 'inputbar { enabled: false;}' | grep -oE "#[0-9a-fA-F]{6}" | head -n 1)
	# if selection made push it to clipboard
	if [[ -n "$CHOICE" ]]; then
		echo "$CHOICE" | tr -d '\n' | wl-copy
	fi

}
main
