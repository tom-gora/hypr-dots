#!/bin/bash

# Rofi menu for color shades

iDIR="$HOME/.config/swaync/images"
pastel=$(which pastel)
hyprpicker=$(which hyprpicker)
missing_deps=()

if [[ -z "$pastel" ]]; then
	missing_deps+=("pastel")
fi
if [[ -z "$hyprpicker" ]]; then
	missing_deps+=("hyprpicker")
fi

if [[ ${#missing_deps[@]} -ne 0 ]]; then
	notify-send -t 4000 -i "$iDIR/rofi-error.svg" "Rofi Error" "Dependencies not found: \
    ${missing_deps[*]} \
    Please install them first."
	exit 1
fi

final_validate_color_from_pastel() {
	local line="$1"
	[[ "$line" =~ ^#[0-9A-Fa-f]{3,8}$ ]]
}

main() {
	SOURCE_COLOR="$(wl-paste)"
	pastel color "$SOURCE_COLOR" >/dev/null 2>&1
	EXIT_CODE=$?

	if [[ $EXIT_CODE -ne 0 ]]; then
		SOURCE_COLOR="$(hyprpicker)"
	fi
	FROM_DARK=$(pastel gradient --number=14 000000 "$SOURCE_COLOR" | pastel format hex | sed '$d')
	INTO_LIGHT=$(pastel gradient --number=14 "$SOURCE_COLOR" ffffff | pastel format hex)
	FULL_GRADIENT_LIST=$(echo -e "$FROM_DARK\n""$INTO_LIGHT")
	declare -a TEMPLATE
	while IFS= read -r line; do

		if ! final_validate_color_from_pastel "$line"; then
			notify-send -t 4000 -i "$iDIR/rofi-error.svg" "Rofi Error" "Invalid color value encountered. Try again."
			exit 1
		fi
		templated_line="        <span bgcolor='$line' fgcolor='$line'>XXXXXXXXXXXXXXXXXXXXXXXXXXX</span>    <span>$line</span>"
		TEMPLATE+=("$templated_line")
	done <<<"$FULL_GRADIENT_LIST"

	MARKUP=$(printf "%s\n" "${TEMPLATE[@]}")
	choice=$(echo "$MARKUP" | rofi -dmenu -config ~/.config/rofi/config-shades.rasi -markup-rows)
	strip_rofi_fluff=$(echo "$choice" | sed -n 's/.*bgcolor="\\([^"]*\\)".*/\\1/p')
	echo "$strip_rofi_fluff" | wl-copy

}
main
