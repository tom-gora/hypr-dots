#!/bin/bash

notif="$HOME/.config/swaync/images/screenshot.png"

notify-send -u critical -i "$notif" "Resize Active Window" "╭───┰───────────────────────────────╮\n│<b>  </b>┃ Up                            │\n\│<b>  </b>┃ Left                          │\n│<b>  </b>┃ Down                          │\n│<b>  </b>┃ Right                         │\n│<b> R </b>┃ Rebalance Vertically          │\n╰───┸───────────────────────────────╯"
