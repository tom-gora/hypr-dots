#!/bin/bash
# Rofi menu for Quick Edit

configs="$HOME/.config/hypr/configs"

send_notification() {
	local message=$1
	notify-send -u normal "Color Picker" "$message"
}
add_alpha() {
	local color=$1
	local alpha=${2:-0.5} # Default alpha value is 0.5
	echo $(echo $color | sed "s/(/a(/; s/)/, $alpha)/")
}

hex_to_decimal() {
	local hex_input=$1
	hex_input=${hex_input#"#"}
	local decimal_value=$((16#$hex_input))
	echo $decimal_value
}

prep_color() {
	#hyprpick color
	local INPUT_CLR=$(hyprpicker --format hex)
	#check for user cancelling pick process
	if [[ -z "$INPUT_CLR" ]]; then
		send_notification "Color picking cancelled 💔"
		exit 1
	fi
	#store bg for rofi
	magick -size 400x225 xc:"$INPUT_CLR" ~/.cache/.rofi-color-picker-bg.png
	local hex=$INPUT_CLR
	local rgb=$(pastel format rgb "$INPUT_CLR" 2>&1)
	local rgba=$(add_alpha "$rgb")
	local hsl=$(pastel format hsl "$INPUT_CLR")
	local hsla=$(add_alpha "$hsl")
	local cmyk=$(pastel format cmyk "$INPUT_CLR")
	local oklab=$(pastel format oklab "$INPUT_CLR")
	local dec=$(hex_to_decimal "$INPUT_CLR")
	#prep json str
	local json_string=$(jq -n \
		--arg hex "$INPUT_CLR" \
		--arg rgb "$rgb" \
		--arg rgba "$rgba" \
		--arg hsl "$hsl" \
		--arg hsla "$hsla" \
		--arg cmyk "$cmyk" \
		--arg oklab "$oklab" \
		--arg dec "$dec" \
		'{
        hex: $hex,
        rgb: $rgb,
        rgba: $rgba,
        hsl: $hsl,
        hsla: $hsla,
        cmyk: $cmyk,
        oklab: $oklab,
        dec: $dec
    }')

	# Save json
	echo "$json_string" >~/.cache/.rofi-color-picker-current.json
}

menu() {
	local JSON_INPUT=$(cat ~/.cache/.rofi-color-picker-current.json)
	HEX=$(echo "$JSON_INPUT" | jq -r '.hex')
	RGB=$(echo "$JSON_INPUT" | jq -r '.rgb')
	RGBA=$(echo "$JSON_INPUT" | jq -r '.rgba')
	HSL=$(echo "$JSON_INPUT" | jq -r '.hsl')
	HSLA=$(echo "$JSON_INPUT" | jq -r '.hsla')
	CMYK=$(echo "$JSON_INPUT" | jq -r '.cmyk')
	OKLAB=$(echo "$JSON_INPUT" | jq -r '.oklab')
	DEC=$(echo "$JSON_INPUT" | jq -r '.dec')

	printf "${HEX}\n"
	printf "${RGB}\n"
	printf "${RGBA}\n"
	printf "${HSL}\n"
	printf "${HSLA}\n"
	printf "${CMYK}\n"
	printf "${OKLAB}\n"
	printf "decimal(${DEC})\n"
}

main() {
	prep_color
	choice=$(menu | rofi -dmenu -config ~/.config/rofi/config-colors.rasi)
	local JSON_INPUT=$(cat ~/.cache/.rofi-color-picker-current.json)
	case $choice in
	"#"*)
		echo "$JSON_INPUT" | jq -r '.hex' | wl-copy
		send_notification "Picked color value: $(echo "$JSON_INPUT" | jq -r '.hex')"
		;;
	"rgb("*)
		echo "$JSON_INPUT" | jq -r '.rgb' | wl-copy
		send_notification "Picked color value: $(echo "$JSON_INPUT" | jq -r '.rgb')"
		;;
	"rgba("*)
		echo "$JSON_INPUT" | jq -r '.rgba' | wl-copy
		send_notification "Picked color value: $(echo "$JSON_INPUT" | jq -r '.rgba')"
		;;
	"hsl("*)
		echo "$JSON_INPUT" | jq -r '.hsl' | wl-copy
		send_notification "Picked color value: $(echo "$JSON_INPUT" | jq -r '.hsl')"
		;;
	"hsla("*)
		echo "$JSON_INPUT" | jq -r '.hsla' | wl-copy
		send_notification "Picked color value: $(echo "$JSON_INPUT" | jq -r '.hsla')"
		;;
	"cmyk("*)
		echo "$JSON_INPUT" | jq -r '.cmyk' | wl-copy
		send_notification "Picked color value: $(echo "$JSON_INPUT" | jq -r '.cmyk')"
		;;
	"OkLab("*)
		echo "$JSON_INPUT" | jq -r '.oklab' | wl-copy
		send_notification "Picked color value: $(echo "$JSON_INPUT" | jq -r '.oklab')"
		;;
	"decimal("*)
		echo "$JSON_INPUT" | jq -r '.dec' | wl-copy
		send_notification "Picked color value: $(echo "$JSON_INPUT" | jq -r '.dec')"
		;;
	*) ;; esac
}

main
