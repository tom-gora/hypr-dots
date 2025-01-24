#!/bin/bash

# helpers
is_update_running() {
	pgrep -f "wez-updater" >/dev/null
}

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

#give the updater a chance to spin up
sleep 0.5
# wait for update to finish
while is_update_running; do
	sleep 1
done
# don't read the file prematurely
sleep 0.5

#---
# Unexpected execution end reuslt
#---

latest_result_cache=$(find /tmp/my_updater.* -mmin -5 -print | tail -n 1)
# if updating script failed to write any state file
if [[ -z $latest_result_cache ]]; then
	notify_failure
	exit 1
fi

state=$(cat $"$latest_result_cache")
# or mktemp'd it but wrote no contents
if [[ -z $state ]]; then
	notify_failure
	exit 1
	# basically indicating soomething failed and upd script routine failed
	# but then also if wrote "in_progress" which mean it stated, but it never
	# got overwritten indicating something died before results arrived from dnf upd
elif [[ $state == *'in_progress'* ]]; then
	notify_failure
	exit 1
fi

#---
# Non unexpected execution end reuslt
#---

# if dnf noot exited cleanly
if [[ $state -ne 0 ]]; then
	notify_failure
	exit 1
	# if nothing to do, then we can exit and notifier will receive the message
elif [[ $state == *'Nothing to do.'* ]]; then
	notify_nothing_to_do
	exit 0
elif [[ $state -eq 0 ]]; then
	notify_success
	exit 0
fi

# post-clean any potential leftovers
for tidy_me in /tmp/my_updater.*; do rm -f "$tidy_me"; done
exit 0
