#!/bin/bash

# pre-clean any potential leftovers
for tidy_me in /tmp/my_updater.*; do rm -f "$tidy_me"; done

# spin up the notifier as a background process immune to this script execution
nohup "$HOME/.config/hypr/scripts/utils/DnfNotifyResults.sh" >/dev/null 2>&1 &

# init a tmp file to store the result
result_cache=$(mktemp -t my_updater.XXXXXXXXXX)
#
# mark the start of the update execution
# if dies/is killed at this point this will indicate to notification
# handler that the update was unsuccessful
echo "in_progress" >"$result_cache"

dnf_says=$(sudo dnf update --refresh)

if [ "$dnf_says" == "Nothing to do." ]; then
	# if nothing to do, then we can exit and notifier will receive the message
	echo "$dnf_says" >"$result_cache"
	exit 0
else
	# else store the exit code
	echo $? >"$result_cache"
fi
