#!/bin/env bash

notif="$HOME/.config/swaync/images/screenshot.svg"

notify-send -t 60000 -i "$notif" "Make a Screenshot" "<span color='#3e8fb0'>┌───┰─────────────────────────────────┐</span>
<span color='#3e8fb0'>│<b> N </b>┃ </span>Full Screenshot Now             <span color='#3e8fb0'>│</span>
<span color='#3e8fb0'>│<b> W </b>┃ </span>Window Only Now                 <span color='#3e8fb0'>│</span>
<span color='#3e8fb0'>│<b> A </b>┃ </span>Area Screenshot                 <span color='#3e8fb0'>│</span>
<span color='#3e8fb0'>│<b> S </b>┃ </span>Full Screenshot Short Wait -5s  <span color='#3e8fb0'>│</span>
<span color='#3e8fb0'>│<b> L </b>┃ </span>Full Screenshot Long Wait -10s  <span color='#3e8fb0'>│</span>
<span color='#3e8fb0'>│<b> E </b>┃ </span>Editable Screenshot             <span color='#3e8fb0'>│</span>
<span color='#3e8fb0'>└───┸─────────────────────────────────┘</span>"
