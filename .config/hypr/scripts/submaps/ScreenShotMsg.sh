#!/bin/bash

notif="$HOME/.config/swaync/images/screenshot.png"

notify-send -u critical -i "$notif" "Make a Screenshot" "╭───┰───────────────────────────────╮\n│<b> N </b>┃ Full Screenshot Now           │\n\│<b> W </b>┃ Window Only Now               │\n│<b> A </b>┃ Area Screenshot               │\n│<b> S </b>┃ Full Screenshot Short Wait -5s│\n│<b> L </b>┃ Full Screenshot Long Wait -10s│\n│<b> E </b>┃ Editable Screenshot           │\n╰───┸───────────────────────────────╯"
