#!/bin/env bash

notif="$HOME/.config/swaync/images/resize.svg"

notify-send -t 60000 -i "$notif" "Resize Active Window" "<span color='#3e8fb0'>┌───┰───────────────────────────────┐</span>
<span color='#3e8fb0'>│<b> K </b>┃ </span>Up                            <span color='#3e8fb0'>│</span>
<span color='#3e8fb0'>│<b> H </b>┃ </span>Left                          <span color='#3e8fb0'>│</span>
<span color='#3e8fb0'>│<b> J </b>┃ </span>Down                          <span color='#3e8fb0'>│</span>
<span color='#3e8fb0'>│<b> L </b>┃ </span>Right                         <span color='#3e8fb0'>│</span>
<span color='#3e8fb0'>│<b> R </b>┃ </span>Rebalance Vertically          <span color='#3e8fb0'>│</span>
<span color='#3e8fb0'>└───┸───────────────────────────────┘</span>"
