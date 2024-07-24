#!/bin/bash
# Rofi menu for Quick Edit

configs="$HOME/.config/hypr/configs"

menu() {
	printf "1. view Window-Rules\n"
	printf "2. view Startup_Apps\n"
	printf "3. view Settings\n"
	printf "4. view Keybinds\n"
	printf "5. view Submap Keybinds\n"
	printf "6. view Env-variables\n"
	printf "7. view Monitors\n"
}

main() {
	choice=$(menu | rofi -dmenu -config ~/.config/rofi/config-compact.rasi | cut -d. -f1)
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
	# 1)
	# 	kitty -e nvim "$configs/WindowRules.conf"
	# 	;;
	# 2)
	# 	kitty -e nvim "$configs/Startup_Apps.conf"
	# 	;;
	# 3)
	# 	kitty -e nvim "$configs/Settings.conf"
	# 	;;
	# 4)
	# 	kitty -e nvim "$configs/Keybinds.conf"
	# 	;;
	# 5)
	# 	kitty -e nvim "$configs/Submap_Keybinds.conf"
	# 	;;
	# 6)
	# 	kitty -e nvim "$configs/ENVariables.conf"
	# 	;;
	# 7)
	# 	kitty -e nvim "$configs/Monitors.conf"
	# 	;;
	*) ;;
	esac
}

main
