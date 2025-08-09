#!/bin/bash

# Rofi menu for tmux sessions

iDIR="$HOME/.config/swaync/images"
# kickstart tmux with a temp named session to the run the ressurect restoration having the server running
if ! pgrep -vx tmux >/dev/null || [[ $(tmux list-sessions 2>/dev/null | wc -l) -eq 0 ]]; then
	tmux new -d -s delete-me &&
		tmux run-shell "$HOME"/.config/tmux/plugins/tmux-resurrect/scripts/restore.sh
fi

# after ressurect ditch the temp session
tmux kill-session -t delete-me

sesh=$(which sesh)
zoxide=$(which zoxide)
fzf=$(which fzf)
missing_deps=()

if [[ -z "$sesh" ]]; then
	missing_deps+=("sesh")
fi
if [[ -z "$zoxide" ]]; then
	missing_deps+=("zoxide")
fi
if [[ -z "$fzf" ]]; then
	missing_deps+=("fzf")
fi

if [[ ${#missing_deps[@]} -ne 0 ]]; then
	notify-send -t 4000 -i "$iDIR/rofi-error.svg" "Rofi Error" "Dependencies not found: \
    ${missing_deps[*]} \
    Please install them first."
fi

main() {
	#retrieve entries from sesh but strip terminal color codes
	SESSIONS=$($sesh list --icons | sed 's/.\[[0-9]\{2\}m//g')

	# NO RETRIEVED SESSIONS FLOW
	if [[ -z "$SESSIONS" ]]; then
		choice=$(printf "1. No sessions found [ Exit ]\n2. No sessions found  [ New ]" | rofi -dmenu -theme-str 'textbox-prompt-icon {str: "  ";}' -theme-str 'entry { placeholder: "TMUX Sessions..."; }')
		case "$choice" in
		"1. No sessions found [ Exit ]")
			pkill -f rofi
			exit 0
			;;
		"2. No sessions found  [ New tmux session]")
			wezterm -e tmux new -s "$USER"_new_session
			;;
		esac
		# AVAILABLE ENTRIES FLOW
	else
		choice=$(echo "$SESSIONS" | rofi -dmenu -theme-str 'textbox-prompt-icon {str: "  ";}' -theme-str 'entry { placeholder: "TMUX Sessions..."; }')
		if [[ -z "$choice" ]]; then
			exit 0
		fi
		wezterm -e "$sesh" connect "$choice"
	fi
}
main
