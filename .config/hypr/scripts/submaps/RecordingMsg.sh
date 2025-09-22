#!/bin/env bash

notif="$HOME/.config/swaync/images/record.svg"

notify-send -c "Wf-recorder" -t 60000 -i "$notif" "Make a Recording" "<span color='#3e8fb0'>┌─────────┰───────────────────────────────┐</span>
<span color='#3e8fb0'>│<b> A       </b>┃ </span>Record area now.              <span color='#3e8fb0'>│</span>
<span color='#3e8fb0'>│<b> Ctrl-A  </b>┃ </span>Record area in 5 sec.         <span color='#3e8fb0'>│</span>
<span color='#3e8fb0'>│<b> Shift-A </b>┃ </span>Record area in 10 sec.        <span color='#3e8fb0'>│</span>
<span color='#3e8fb0'>│<b> W </b>      ┃ </span>Record window now.            <span color='#3e8fb0'>│</span>
<span color='#3e8fb0'>│<b> Ctrl-W  </b>┃ </span>Record window in 5 sec.       <span color='#3e8fb0'>│</span>
<span color='#3e8fb0'>│<b> Shift-W </b>┃ </span>Record window in 10 sec.      <span color='#3e8fb0'>│</span>
<span color='#3e8fb0'>│<b> L </b>      ┃ </span>Record left screen now.       <span color='#3e8fb0'>│</span>
<span color='#3e8fb0'>│<b> Ctrl-L </b> ┃ </span>Record left screen in 5sec.   <span color='#3e8fb0'>│</span>
<span color='#3e8fb0'>│<b> Shift-L </b>┃ </span>Record left screen in 10 sec. <span color='#3e8fb0'>│</span>
<span color='#3e8fb0'>│<b> R </b>      ┃ </span>Record right screen now.      <span color='#3e8fb0'>│</span>
<span color='#3e8fb0'>│<b> Ctrl-R </b> ┃ </span>Record right screen in 5sec.  <span color='#3e8fb0'>│</span>
<span color='#3e8fb0'>│<b> Shift-R </b>┃ </span>Record right screen in 10 sec.<span color='#3e8fb0'>│</span>
<span color='#3e8fb0'>└─────────┸───────────────────────────────┘</span>"
