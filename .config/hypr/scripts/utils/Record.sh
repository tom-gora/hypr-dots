#!/bin/env bash
# Recordings scripts
set -x

icon="${HOME}/.config/swaync/images/record.svg"
time=$(date "+%d-%b_%H-%M-%S")
dir="$(xdg-user-dir)/Videos/Recordings"
file="Recording_${time}_${RANDOM}.mp4"

# notify and cache the recording path
notify_view() {
	local check_file="$dir/$file"
	if [[ -e "$check_file" ]]; then
		notify-send -u normal -i "$icon" -c "Wf-recorder" "Recording saved." "Click to view\n\n${file}"
		echo "${check_file}" >/tmp/recent_recording.txt
	fi
}

# countdown
countdown() {
	for sec in $(seq $1 -1 1); do
		notify-send -t 500 -c "Wf-recorder" "Starting recording in" "<b>$sec</b>"
		sleep 1
	done
	swaync-client --close-latest
}

# record functions
recArea() {
	swaync-client --close-latest
	local coordinates=$(slurp -b "#2A273FDD" -w 0)
	if [[ "$coordinates" == "" ]]; then
		exit 0
	fi
	if [[ -n "$1" ]]; then
		countdown "$1"
	fi
	cd ${dir} && wf-recorder -a -g "$coordinates" -f ${file}
	sleep 0.5
	notify_view
}

recWin() {
	swaync-client --close-latest
	local w_pos=$(hyprctl activewindow | grep 'at:' | cut -d':' -f2 | tr -d ' ' | tail -n1)
	local w_size=$(hyprctl activewindow | grep 'size:' | cut -d':' -f2 | tr -d ' ' | tail -n1 | sed s/,/x/g)
	local coordinates="$w_pos $w_size"
	echo ${coordinates}
	if [[ -n "$1" ]]; then
		countdown "$1"
	fi
	cd ${dir} && wf-recorder -a -g "$coordinates" -f ${file}
	sleep 0.5
	notify_view
}

recLeftMonitor() {
	swaync-client --close-latest
	if [[ -n "$1" ]]; then
		countdown "$1"
	fi
	cd ${dir} && wf-recorder -a -o DP-1 -f ${file}
	sleep 0.5
	notify_view
}

recRightMonitor() {
	swaync-client --close-latest
	if [[ -n "$1" ]]; then
		countdown "$1"
	fi
	cd ${dir} && wf-recorder -a -o HDMI-A-1 -f ${file}
	sleep 0.5
	notify_view
}

if [[ ! -d "$dir" ]]; then
	mkdir -p "$dir"
fi

if [[ "$1" == "--win" ]]; then
	if [[ -z "$2" || "$2" == "0" ]]; then
		recWin 0
	else
		recWin "$2"
	fi
elif [[ "$1" == "--area" ]]; then
	if [[ -z "$2" || "$2" == "0" ]]; then
		recArea 0
	else
		recArea "$2"
	fi
elif [[ "$1" == "--left" ]]; then
	if [[ -z "$2" || "$2" == "0" ]]; then
		recLeftMonitor 0
	else
		recLeftMonitor "$2"
	fi
elif [[ "$1" == "--right" ]]; then
	if [[ -z "$2" || "$2" == "0" ]]; then
		recRightMonitor 0
	else
		recRightMonitor "$2"
	fi
else
	echo -e "Available Options : --win --area --left --right  and integer for delay"
fi

exit 0
