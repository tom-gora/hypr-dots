#!/bin/bash

__toggle_get_win_params() {
	local case="$1"
	local query="$2"

	if [ "$case" == "object" ] && [ "$query" == "Scratchpad" ]; then
		result=$(hyprctl clients -j | jq --arg q "$query" '.[] | select(.class | test($q))')
		echo "$result"
		exit 0
	elif [ "$case" == "object" ] && [ "$query" != "Scratchpad" ]; then
		result=$(hyprctl clients -j | jq --arg q "$query" '.[] | select(.initialTitle | test($q))')
		echo "$result"
		exit 0
	elif [ "$case" == "workspace" ] && [ "$query" == "Scratchpad" ]; then
		result=$(hyprctl clients -j | jq --arg q "$query" '.[] | select(.class | test($q))')
		out=$(jq -r --arg key "$case" '.[$key].name' <<<"$result")
		echo "$out"
		exit 0
	elif [ "$case" == "workspace" ] && [ "$query" != "Scratchpad" ]; then
		result=$(hyprctl clients -j | jq --arg q "$query" '.[] | select(.initialTitle | test($q))')
		out=$(jq -r --arg key "$case" '.[$key].name' <<<"$result")
		echo "$out"
		exit 0
	elif [ "$case" != "object" ] && [ "$case" != "workspace" ] && [ "$query" == "Scratchpad" ]; then
		result=$(hyprctl clients -j | jq --arg q "$query" '.[] | select(.class | test($q))')
		out=$(jq -r --arg key "$case" '.[$key]' <<<"$result")
		echo "$out"
		exit 0
	elif [ "$case" != "object" ] && [ "$case" != "workspace" ] && [ "$query" != "Scratchpad" ]; then
		result=$(hyprctl clients -j | jq --arg q "$query" '.[] | select(.initialTitle | test($q))')
		out=$(jq -r --arg key "$case" '.[$key]' <<<"$result")
		echo "$out"
		exit 0
	else
		echo "false"
	fi

}

__toggle_set_query_string() {
	case $1 in
	scratchpad)
		echo "Scratchpad"
		exit 0
		;;
	spotify)
		echo "Spotify"
		exit 0
		;;
	discord)
		echo "Discord"
		exit 0
		;;
	joplin)
		echo "Joplin"
		exit 0
		;;
	thunderbird)
		echo "Mozilla Thunderbird"
		exit 0
		;;
	ollama)
		echo "Ollama"
		exit 0
		;;
	*)
		echo "false"
		exit 1
		;;
	esac
}
