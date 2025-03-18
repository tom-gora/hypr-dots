#!/bin/bash

# pre-clean any potential leftovers
cleanup() {
	for tidy_me in /tmp/my_updater.*; do rm -f "$tidy_me"; done
}
trap cleanup EXIT INT TERM

# init a tmp file to store the result
result_cache=$(mktemp -t my_updater.XXXXXXXXXX)

#
# mark the start of the update execution
# if dies/is killed at this point this will indicate to notification
# handler that the update was unsuccessful
echo "in_progress" >"$result_cache"

dnf_output=$(sudo dnf update --refresh)
exit_code=$?

if echo "$dnf_output" | grep -q "Nothing to do."; then
	# if nothing to do, then we can exit and notifier will receive the message
	echo "$dnf_output" >"$result_cache"
else
	# else store the exit code
	echo "$exit_code" >"$result_cache"
fi
# spin up the notifier as a background process immune to this script execution
nohup "$HOME/.config/hypr/scripts/utils/DnfNotifyResults.sh" >/dev/null 2>&1 &

sleep 1
exit 0
