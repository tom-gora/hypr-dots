#!/bin/bash
# Screenshots scripts

icon="${HOME}/.config/swaync/images/screenshot.png"
time=$(date "+%d-%b_%H-%M-%S")
dir="$(xdg-user-dir)/Pictures/Screenshots"
file="Screenshot_${time}_${RANDOM}.png"

# notify and cache the screenshot path
notify_view() {
	local check_file="$dir/$file"
	if [[ -e "$check_file" ]]; then
		if [[ $1 == "win" ]]; then
			notify-send -u low -i ${icon} "Screenshot of [ ${2} ] saved." "Click to view\n\n${file}"
			echo "${check_file}" >/tmp/recent_screenshot.txt
		else
			notify-send -u low -i ${icon} "Screenshot saved." "Click to view\n\n${file}"
			echo "${check_file}" >/tmp/recent_screenshot.txt
		fi
	fi
}

# countdown
countdown() {
	for sec in $(seq $1 -1 1); do
		notify-send -t 500 "Taking shot in" "<b>$sec</b>"
		sleep 1
	done
	swaync-client --close-latest
}

# take shots functions
shotnow() {
	swaync-client --close-latest
	cd ${dir} && grim - | tee "$file" | wl-copy
	sleep 0.5
	notify_view
}

shot5() {
	swaync-client --close-latest
	countdown '5'
	cd ${dir} && grim - | tee "$file" | wl-copy
	sleep 0.5
	notify_view

}

shot10() {
	swaync-client --close-latest
	countdown '10'
	cd ${dir} && grim - | tee "$file" | wl-copy
	sleep 0.5
	notify_view
}

shotwin() {
	swaync-client --close-latest
	local win_class=$(hyprctl activewindow -j | jq -r '(.class)')
	local w_pos=$(hyprctl activewindow | grep 'at:' | cut -d':' -f2 | tr -d ' ' | tail -n1)
	local w_size=$(hyprctl activewindow | grep 'size:' | cut -d':' -f2 | tr -d ' ' | tail -n1 | sed s/,/x/g)
	sleep 1 #give notification time to get dismissed
	cd ${dir} && grim -g "$w_pos $w_size" - | tee "$file" | wl-copy
	notify_view "win" ${win_class}
}

shotarea() {
	swaync-client --close-latest

	local coordinates=$(slurp -b "#2A273FDD" -w 0)
	if [[ "$coordinates" == "" ]]; then
		exit 0
	fi
	cd ${dir} && grim -g "$coordinates" - | tee "$file" | wl-copy
	notify_view
}

if [[ ! -d "$dir" ]]; then
	mkdir -p "$dir"
fi

if [[ "$1" == "--now" ]]; then
	shotnow
elif [[ "$1" == "--in5" ]]; then
	shot5
elif [[ "$1" == "--in10" ]]; then
	shot10
elif [[ "$1" == "--win" ]]; then
	shotwin
elif [[ "$1" == "--area" ]]; then
	shotarea
else
	echo -e "Available Options : --now --in5 --in10 --win --area --active"
fi

exit 0
