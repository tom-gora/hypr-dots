#!/bin/env bash

# continuously poll for clients slow to start up until they launch
# to avoid prematurely failing, if failed still after a minute, only then
# return empty result to let main script handle and notify in UI
__get_clients_data() {
	local result=""
	local timeout_limit=60
	local elapsed_time=0
	local interval=5

	while [ "$elapsed_time" -lt "$timeout_limit" ]; do
		result=$(hyprctl clients -j)
		if [ -n "$result" ]; then
			echo "$result"
			return
		fi
		sleep "$interval"
		elapsed_time=$((elapsed_time + interval))
	done

	echo ""
}

# get client data to act on from hyprctl and extract relevant values depending on the client called using jq
__toggle_get_win_params() {
	local case="$1"
	local query="$2"

	if [ "$case" == "object" ] && [ "$query" == "Scratchpad" ]; then
		result=$(__get_clients_data | jq --arg q "$query" '.[] | select(.class | test($q))')
		echo "$result"
		exit 0
	elif [ "$case" == "object" ] && [ "$query" != "Scratchpad" ]; then
		result=$(__get_clients_data | jq --arg q "$query" '.[] | select(.initialTitle | test($q))')
		echo "$result"
		exit 0
	elif [ "$case" == "workspace" ] && [ "$query" == "Scratchpad" ]; then
		result=$(__get_clients_data | jq --arg q "$query" '.[] | select(.class | test($q))')
		out=$(jq -r --arg key "$case" '.[$key].name' <<<"$result")
		echo "$out"
		exit 0
	elif [ "$case" == "workspace" ] && [ "$query" != "Scratchpad" ]; then
		result=$(__get_clients_data | jq --arg q "$query" '.[] | select(.initialTitle | test($q))')
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

# translate the arg to a viable query string that hyprctl and jq can use to target client
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
	thunderbird)
		echo "Mozilla Thunderbird"
		exit 0
		;;
	ollama)
		echo "Ollama"
		exit 0
		;;
	obsidian)
		echo "obsidian"
		exit 0
		;;
	*)
		echo "false"
		exit 1
		;;
	esac
}
