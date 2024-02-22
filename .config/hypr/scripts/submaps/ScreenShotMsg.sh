#!/bin/bash

notif="$HOME/.config/swaync/images/screenshot.png"

notify-send -t 60000 -i "$notif" "Make a Screenshot" "╭───┰───────────────────────────────╮
│<b> N </b>┃ Full Screenshot Now           │
│<b> W </b>┃ Window Only Now               │
│<b> A </b>┃ Area Screenshot               │
│<b> S </b>┃ Full Screenshot Short Wait -5s│
│<b> L </b>┃ Full Screenshot Long Wait -10s│
│<b> E </b>┃ Editable Screenshot           │
╰───┸───────────────────────────────╯"
