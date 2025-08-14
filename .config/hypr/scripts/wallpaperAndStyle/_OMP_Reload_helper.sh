#!/bin/env bash

WALLUST_OMP_PALETTE_FILE="$HOME/.cache/wallust/targets/omp.json"
OMP_CONFIG_FILE="$HOME/.config/my_omp.json"
OMP_CONFIG_FILE2="$HOME/.config/my_scratchpad_omp.json"

if [[ ! -f "$WALLUST_OMP_PALETTE_FILE" ]]; then
	echo "Error: New Oh My Posh palette file not found at $WALLUST_OMP_PALETTE_FILE." >&2
fi

if [[ ! -f "$OMP_CONFIG_FILE" ]]; then
	echo "Error: Oh My Posh config file not found at $OMP_CONFIG_FILE." >&2
fi

NEW_PALETTE_CONTENT NEW_CONFIG_CONTENT
NEW_PALETTE_CONTENT=$(<"$WALLUST_OMP_PALETTE_FILE")

NEW_CONFIG_CONTENT=$(jq --argjson new_palette "$NEW_PALETTE_CONTENT" '.palette = $new_palette' "$OMP_CONFIG_FILE")
NEW_CONFIG_CONTENT2=$(jq --argjson new_palette "$NEW_PALETTE_CONTENT" '.palette = $new_palette' "$OMP_CONFIG_FILE2")
echo "$NEW_CONFIG_CONTENT" >"$OMP_CONFIG_FILE"
if [ "$?" -ne 0 ]; then
	echo "Error: Failed to update Oh My Posh config file with jq." >&2
fi
echo "$NEW_CONFIG_CONTENT2" >"$OMP_CONFIG_FILE2"
if [ "$?" -ne 0 ]; then
	echo "Error: Failed to update Oh My Posh config file with jq." >&2
fi
