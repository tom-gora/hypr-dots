#!/bin/bash

output=$(ollama ps)

second_line=$(echo "$output" | awk 'NR==2')

name=$(echo "$second_line" | cut -d ':' -f 1)

if [ -z "$name" ]; then
	echo ""
	exit 0
fi
echo "  $name "
exit 0
