#!/usr/bin/env bash
#determine terminal from environment
term="$TERMINAL"
init_z() {
	# first dependency check
	if ! command -v zoxide &>/dev/null; then
		notify-send -u critical "This script Zoxide to be installed on the system"
		exit 1
	fi

	echo "Initializing zoxide for bash..."
	local RC="$HOME/.bashrc"
	if [[ -f "$RC" ]]; then
		# Check if the line is already in .bashrc
		if ! grep -Fxq 'eval "$(zoxide init bash)"' "$RC"; then
			echo 'eval "$(zoxide init bash)"' >>"$RC"
			source "$RC"
		fi
	else
		# if no default rc config file then init in place
		eval "$(zoxide init bash)"
	fi
}

query() {
	# arr for deduplication
	declare -A seen
	zoxide query --all -l | while read -r dir; do
		# strip path
		dir_name=$(basename "$dir")
		# strip potential not existing, deleted, not mounted and otherwise not accessible directories
		if [ ! -d "$dir" ]; then
			zoxide remove "$dir"
		else
			# if path valid route
			if [[ -z ${seen["$dir_name"]} ]]; then
				# if no duplicate push to arr and print
				seen["$dir_name"]=1
				echo "$dir_name"
			fi
		fi
	done
}

main() {
	# init zoxide if necessary
	type_res=$(type z 2>&1)
	if echo "$type_res" | grep -qi "function"; then
		init_z
	fi

	# query zoxide to build menu
	if [[ ! $(pidof rofi) ]]; then
		choice="$(query | rofi -dmenu)"
		if [[ -n "$choice" ]]; then
			# get command as string
			command="z $choice"
			# and decidehow to launch
			case "$term" in
			"wezterm")
				echo "wezterm"
				wezterm cli spawn --new-window -- "$SHELL" -ic "$command; exec $SHELL"
				;;
			"kitty")
				echo "kitty"
				kitty "$SHELL" -ic "$command; exec $SHELL"
				;;
			*)
				echo "default"
				path=$(zoxide query "$choice")
				xdg-open "$path"
				;;
			esac
		else
			# if no choice kill rofi
			pkill rofi
		fi
	else
		# if attempting to louch rofi more than once kill rofi (same binding for off on)
		pkill rofi
	fi
}

main
