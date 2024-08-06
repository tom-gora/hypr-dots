#!/bin/bash

notif="$HOME/.config/swaync/images/screenshot.png"

notify-send -c "Wf-recorder" -t 60000 -i "$notif" "Make a Recording" "┌─────────┰───────────────────────────────┐
│<b> A       </b>┃ Record area now.              │
│<b> Ctrl-A  </b>┃ Record area in 5 sec.         │
│<b> Shift-A </b>┃ Record area in 10 sec.        │
│<b> W </b>      ┃ Record window now.            │
│<b> Ctrl-W  </b>┃ Record window in 5 sec.       │
│<b> Shift-W </b>┃ Record window in 10 sec.      │
│<b> L </b>      ┃ Record left screen now.       │
│<b> Ctrl-L </b> ┃ Record left screen in 5sec.   │
│<b> Shift-L </b>┃ Record left screen in 10 sec. │
│<b> R </b>      ┃ Record right screen now.      │
│<b> Ctrl-R </b> ┃ Record right screen in 5sec.  │
│<b> Shift-R </b>┃ Record right screen in 10 sec.│
└─────────┸───────────────────────────────┘"
