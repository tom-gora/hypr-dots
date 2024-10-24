#!/bin/bash

# Rofi / FZF menu for Zellij Sessions

#home-relative path to not have issues with bash not seeing same path as zsh does
zellij=/home/tomeczku/.config/cargo/bin/zellij

SESSIONS=$($zellij list-sessions --no-formatting --short)
FZF_ARGS="--no-mouse --cycle --border=rounded --height=50% --border-label-pos=3 --margin=10,20 --padding=2,1 --color=border:#296883,separator:#296883,label:#c4a7e7,prompt:#eb6f92,fg+:#e0def4"
FZF_PROMPT='--prompt=  '
FZF_TITLE='--border-label= SELECT ZELLIJ SESSION TO ATTACH '
IFS=' ' read -r -a FZF_ARGS_ARRAY <<<"$FZF_ARGS"

# if an arg passed, any arg really conditionally enter in-terminaal flow for displaying in term session selection
handle_t_flag() {
	local t_value="$1"

	if [ "$t_value" == "1" ]; then
		echo "true"
	elif [ "$t_value" == "0" ]; then
		echo "false"
	else
		echo "Error: -t requires an argument of either 1 or 0."
		exit 1
	fi
}

TERM_MENU="false"

while getopts ":t:" opt; do
	case $opt in
	t)
		if [[ "$OPTARG" == "1" || "$OPTARG" == "0" ]]; then
			TERM_MENU=$(handle_t_flag "$OPTARG")
		else
			echo "Error: -t flag is required with an argument of either 1 or 0."
			exit 1
		fi
		;;
	\\?)
		echo "Error: -t flag is required with an argument of either 1 or 0."
		exit 1
		;;
	:)
		echo "Error: -t flag is required with an argument of either 1 or 0."
		exit 1
		;;
	esac
done

main() {
	# NO AVAILABLE SESSIONS FLOW
	if [[ -z "$SESSIONS" ]]; then
		# if term menu requested and no sessions to attach to, just open new term no extra steps
		if [[ "$TERM_MENU" == "true" ]]; then
			exit 0
		fi
		# else we're assuming user-invoked rofi menu and giving choice to abandon or create new session
		choice=$(printf "1. No sessions found [ Exit ]\n2. No sessions found  [ New ]" | rofi -dmenu -config ~/.config/rofi/config-zellij.rasi)
		case "$choice" in
		"1. No sessions found [ Exit ]")
			pkill -f rofi
			exit 0
			;;
		"2. No sessions found  [ New ]")
			wezterm -e "$zellij"
			;;
		esac
		# AVAILABLE SESSIONS FLOW
		# if term menu requested open terminal and allow to choose session via fzf
	else
		if [[ "$TERM_MENU" == "true" ]]; then
			SESSION_CHOICE="$(echo "$SESSIONS" | fzf "${FZF_ARGS_ARRAY[@]}" "$FZF_TITLE" "$FZF_PROMPT")"
			"$zellij" attach "$SESSION_CHOICE"
			exit 0
		fi
		# else choose available session from menu invoked
		choice=$(echo "$SESSIONS" | rofi -dmenu -config ~/.config/rofi/config-zellij.rasi)
		if [[ -z "$choice" ]]; then
			exit 0
		fi
		wezterm -e "$zellij" attach "$choice"
	fi
}
main
