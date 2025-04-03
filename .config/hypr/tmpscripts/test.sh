#!/usr/bin/env bash

CACHE_DIR="$HOME/.cache/currently-played"
PLACEHOLDER="$HOME/.config/hypr/scripts/hyprlock/assets/placeholder.gif"

if [ ! -d "$CACHE_DIR" ]; then
	mkdir -p "$CACHE_DIR"
fi

ARTURL=$(playerctl metadata --format '{{mpris:artUrl}}')
STATUS=$(playerctl status)
TITLE=$(playerctl metadata --format '{{title}}')
ARTIST=$(playerctl metadata --format '{{artist}}')
LENGTH=$(playerctl metadata --format '{{mpris:length}}')
POSITION=$(playerctl position --format '{{position}}')
LENGTH=$((LENGTH / 1000000))
POSITION=$((POSITION / 1000000))

HASH=$(echo -n "$TITLE" | md5sum | awk '{ print $1 }')
IMGPATH="$CACHE_DIR/$HASH.png"

if [[ "$ARTURL" == file://* ]]; then
	ARTURL="${ARTURL#file://}"
fi

PLAYER=$(playerctl -l | grep 'brave.instance' || true)

if [[ "$ARTURL" == *".org.chromium.Chromium"* || -n "$PLAYER" ]]; then
	FLATPAK_APP="com.brave.Browser" # Adjust if using a different Flatpak app

	# Check if image exists inside Flatpak
	if flatpak run --command=sh "$FLATPAK_APP" -c "[ -f \"$ARTURL\" ]"; then
		# Copy image from Flatpak sandbox
		TEMP_PATH="/tmp/$(basename "$ARTURL")"

		# Using bash -c to cp the file within Flatpak sandbox
		flatpak run --command=bash "$FLATPAK_APP" -c "cp '$ARTURL' '$TEMP_PATH'"

		# Move the file to the actual location outside the sandbox using flatpak-spawn
		flatpak-spawn --host mv "$TEMP_PATH" "$IMGPATH"
	fi
else
	# Regular case: Copy file if exists
	if [ -f "$ARTURL" ]; then
		cp "$ARTURL" "$IMGPATH"
	fi
fi

if [ ! -s "$IMGPATH" ]; then
	cp "$PLACEHOLDER" "$CACHE_DIR/placeholder.gif"
fi

JSON="{\"length\":\"$LENGTH\", \"position\":\"$POSITION\", \"artUrl\":\"$ARTURL\", \"status\":\"$STATUS\", \"title\":\"$TITLE\", \"artist\":\"$ARTIST\"}"

echo "$JSON"
