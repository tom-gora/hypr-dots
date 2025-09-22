#!/bin/env bash

time=$(date "+%d-%b_%H-%M-%S")
dir="$(pwd)/screenshot_dump"
file="shot_${time}_${RANDOM}.png"
jpeg_file="shot_${time}_${RANDOM}.jpg"

get_file() {
	local w_pos=$(hyprctl activewindow | grep 'at:' | cut -d':' -f2 | tr -d ' ' | tail -n1)
	local w_size=$(hyprctl activewindow | grep 'size:' | cut -d':' -f2 | tr -d ' ' | tail -n1 | sed s/,/x/g)
	sleep 1 #give notification time to get dismissed
	grim -g "$w_pos $w_size" "$dir/$file"

	# Compress using ImageMagick (convert) to JPEG
	magick "$dir/$file" -resize 50% -quality 60 "$dir/$jpeg_file"
	# Check if convert command was successful
	if [ $? -ne 0 ]; then
		echo "Error: ImageMagick convert failed." >&2
		rm -f "$dir/$file" # Clean up the PNG if conversion failed
		exit 1
	fi

	# Remove the original PNG file (optional, but recommended to save space)
	rm -f "$dir/$file"

	# Encode the JPEG file to base64
	local base64_img=$(base64 -w 0 "$dir/$jpeg_file")

	# Hit the endpoint silently
	curl -s -X POST "http://localhost:6969" \
		-H "Content-Type: application/json" \
		-d "{\"image\": \"$base64_img\"}" >/dev/null

	# Print OK when done
	echo "OK"
}

get_file
