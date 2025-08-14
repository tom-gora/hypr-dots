#!/bin/env bash
# Function to format the tooltip message
waybar_tooltip() {
	echo "$1" | while read -r line; do
		count="${#line}"
		[ "$count" -lt 69 ] && line="${line}$(printf "%$((69 - count))s")"
		printf '%s' "$line "
	done
}

result=$(dnf check-update --refresh 2>/dev/null)
# Get the number of updates
#
read -r number tooltip < <(echo "$result" | awk '
    BEGIN {count = 0; tooltip = ""}
    /^[[:alnum:]-]+\.[[:alnum:]]+/ {count++; if (count <= 10) tooltip = tooltip $0 "\n"}
    END {print count, tooltip}
')

# Trim trailing newline from tooltip
tooltip=$(echo -e "$tooltip" | sed '$ d')

if [ "$number" -eq 0 ]; then
	json_output=$(echo -e '{ "text": " ", "tooltip": "No pending updates", "class": "updates" }')
	echo "$json_output"
	exit 0
else
	json_output=$(printf '{ "text": " %s", "tooltip": "%s", "class": "updates" }' "$number" "$(waybar_tooltip "$tooltip")")
	echo "$json_output"
fi
