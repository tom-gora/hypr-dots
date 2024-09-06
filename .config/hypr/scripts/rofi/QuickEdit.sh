#!/bin/bash
# Rofi menu for Quick Edit

configs="$HOME/.config/hypr/configs"

menu() {
	printf "1. Window-Rules\n"
	printf "2. Startup_Apps\n"
	printf "3. Settings\n"
	printf "4. Keybinds\n"
	printf "5. Submap Keybinds\n"
	printf "6. Env-variables\n"
	printf "7. Monitors\n"
}

main() {
	choice=$(menu | rofi -dmenu -config ~/.config/rofi/config-quick-settings.rasi | cut -d. -f1)
	exit_code=$?
	case $choice in
	1)
		wezterm start -- nvim "$configs/WindowRules.conf"
		;;
	2)
		wezterm start -- nvim "$configs/Startup_Apps.conf"
		;;
	3)
		wezterm start -- nvim "$configs/Settings.conf"
		;;
	4)
		wezterm start -- nvim "$configs/Keybinds.conf"
		;;
	5)
		wezterm start -- nvim "$configs/Submap_Keybinds.conf"
		;;
	6)
		wezterm start -- nvim "$configs/ENVariables.conf"
		;;
	7)
		wezterm start -- nvim "$configs/Monitors.conf"
		;;
	esac
}

main
