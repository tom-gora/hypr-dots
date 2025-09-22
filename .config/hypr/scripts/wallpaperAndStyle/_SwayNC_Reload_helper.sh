#!/bin/env bash

# replace color for all SVG images used in notifications
# ahead of calling css reload on swaync

CSS_FILE="$HOME/.cache/wallust/targets/waybar.css"
SVG_DIR="$HOME/.config/swaync/images"
REGEX='@define-color color13\s*([^;]+);'

COLOR_LINE=$(grep "color13" "$CSS_FILE")

if [[ -z "$COLOR_LINE" ]]; then
	exit 1
fi

if [[ "$COLOR_LINE" =~ $REGEX ]]; then
	GENERATED_COLOR="${BASH_REMATCH[1]}"
	GENERATED_COLOR=$(echo "$GENERATED_COLOR" | tr -d ' ')
else
	exit 1
fi

if [[ -z "$GENERATED_COLOR" ]]; then
	exit 1
fi

find "$SVG_DIR" -type f -name "*.svg" | while IFS= read -r svg_file; do
	LINE_NUM=$(grep -n "style=\"color:" "$svg_file" | cut -d: -f1)
	sed -i "${LINE_NUM}s/.*style=\"color:[^;]*;.*/   style=\"color:${GENERATED_COLOR};\"/" "$svg_file"
done

swaync-client -rs

exit 0
