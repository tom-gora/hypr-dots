#!/bin/env bash

# set -x

iDIR="$HOME/.config/swaync/images"
BIN="$HOME/.config/rofi/backend/bin/gmenu"
POWERMENU_CONF="$HOME/.config/rofi/backend/menus/powermenu.json"
ROFI_POWERMENU_CONFIG="$HOME/.config/rofi/config-powermenu.rasi"

SCRIPT_DIR=$(dirname "$0")
source "$SCRIPT_DIR/notificationsHelpers.sh"

send_notification() {
	local message=$1
	local formatted_message
	formatted_message=$(format_message "$message")
	printf -v message_expanded "%b" "$formatted_message"

	notify-send -u normal -i "$iDIR/dropper.svg" -a "Color Picker" "$message_expanded"
}

main() {
	ACTION=$("$BIN" menu -m "$POWERMENU_CONF" |
		rofi -dmenu -config "$ROFI_POWERMENU_CONFIG" \
			-markup-rows 2>/dev/null)

	if [[ "$ACTION" =~ [Ee]rror ]]; then
		swaync-client --close-latest
		send_notification "Error:\n$RESULT"
		exit 1
	fi

	"$BIN" menu -m "$POWERMENU_CONF" -r "$ACTION"
}
main
