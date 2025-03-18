#!/bin/bash

STATE_FILE_PATTERN="/tmp/my_updater.*"
state_content=""

notify_nothing_to_do() {
	notify-send -t 3000 -i "$HOME/.config/swaync/images/fedora.svg" \
		"DNF" "Nothing to do. Fedora is up to date!\n"
	sleep 3
	swaync-client --close-latest
}

notify_success() {
	notify-send -t 3000 -i "$HOME/.config/swaync/images/fedora.svg" \
		"DNF" "Fedora updated successfully!\n"
	sleep 3
	swaync-client --close-latest
}

notify_failure() {
	notify-send -t 3000 -i "$HOME/.config/swaync/images/fedora.svg" \
		"DNF" "Fedora failed to update.\n"
	sleep 3
	swaync-client --close-latest
}

notify_failure_unexpected() {
	notify-send -t 3000 -i "$HOME/.config/swaync/images/fedora.svg" \
		"Unexpected state content: $1 n\DNF" "Fedora failed to update.\n"
	sleep 3
	swaync-client --close-latest
}

while pgrep -f "wez-updater" >/dev/null; do
	latest_state_file=$(find /tmp -maxdepth 1 -name "my_updater.*" -type f | head -n 1)

	if [[ -z $latest_state_file ]]; then
		sleep 0.5
		exit 1
	fi

	state_content=$(cat "$latest_state_file")
	if [[ -z "$state_content" || "$state_content" == "in_progress" ]]; then
		continue
	else
		break
	fi
done

if [[ -z $state_content ]]; then
	exit 1
elif [[ $state_content == "Nothing to do." ]]; then
	notify_nothing_to_do
elif [[ $state_content =~ ^[0-9]+$ ]]; then
	if [[ $state_content -eq 0 ]]; then
		notify_success
	else
		notify_failure
	fi
else
	notify_failure_unexpected "$state_content"
fi
exit 0
