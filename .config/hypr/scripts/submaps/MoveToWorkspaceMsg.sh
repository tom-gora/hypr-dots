#!/bin/env bash

notif="$HOME/.config/swaync/images/move.svg"

notify-send -t 60000 -i "$notif" "Move active window to workspace" "<span color='#3e8fb0'>┌───┰───────────────────────────────┐</span>
<span color='#3e8fb0'>│<b> 1 </b>┃ </span>move to 1                     <span color='#3e8fb0'>│</span>
<span color='#3e8fb0'>│<b> 2 </b>┃ </span>move to 2                     <span color='#3e8fb0'>│</span>
<span color='#3e8fb0'>│<b> 3 </b>┃ </span>move to 3                     <span color='#3e8fb0'>│</span>
<span color='#3e8fb0'>│<b> 4 </b>┃ </span>move to 4                     <span color='#3e8fb0'>│</span>
<span color='#3e8fb0'>│<b> 5 </b>┃ </span>move to 5                     <span color='#3e8fb0'>│</span>
<span color='#3e8fb0'>│<b> 6 </b>┃ </span>move to 6                     <span color='#3e8fb0'>│</span>
<span color='#3e8fb0'>│<b> 7 </b>┃ </span>move to 7                     <span color='#3e8fb0'>│</span>
<span color='#3e8fb0'>│<b> 8 </b>┃ </span>move to 8                     <span color='#3e8fb0'>│</span>
<span color='#3e8fb0'>│<b> 9 </b>┃ </span>move to 9                     <span color='#3e8fb0'>│</span>
<span color='#3e8fb0'>│<b> 0 </b>┃ </span>move to 10                    <span color='#3e8fb0'>│</span>
<span color='#3e8fb0'>│<b> l </b>┃ </span>move to next workspace        <span color='#3e8fb0'>│</span>
<span color='#3e8fb0'>│<b> h </b>┃ </span>move to previous workspace    <span color='#3e8fb0'>│</span>
<span color='#3e8fb0'>└───┸───────────────────────────────┘</span>"
