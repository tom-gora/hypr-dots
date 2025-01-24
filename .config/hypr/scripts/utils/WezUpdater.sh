#!/bin/bash

for tidy_me in /tmp/my_updater.*; do rm -f "$tidy_me"; done

store_exit_code=$(mktemp -t my_updater.XXXXXXXXXX)
echo "in_progress" >"$store_exit_code"

dnf_says=$(sudo dnf update --refresh)
if [ "$dnf_says" == "Nothing to do." ]; then
	notify-send -t 3000 -i "$HOME/.config/swaync/images/fedora.svg" \
		"DNF" "$dnf_says Fedora is up to date!\n"
	exit 0
fi

echo $? >"$store_exit_code"

output="$(cat "$store_exit_code")"

if [ "$output" -eq 0 ]; then
	notify-send -t 3000 -i "$HOME/.config/swaync/images/fedora.svg" \
		"DNF" "Fedora updated successfully!\n"
elif [ "$output" -eq 1 ]; then
	notify-send -t 3000 -i "$HOME/.config/swaync/images/fedora.svg" \
		"DNF" "Fedora failed to update.\n"
fi

for tidy_me in /tmp/my_updater.*; do rm -f "$tidy_me"; done
