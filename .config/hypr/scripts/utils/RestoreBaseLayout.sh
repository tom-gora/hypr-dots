#!/bin/bash

#grab the active workspace
ACTIVE_WS=$(hyprctl activeworkspace -j | jq -r '.id')

#grab clients on active
CLIENTS_ACTIVE_ADDR=$(hyprctl clients -j | jq -r --arg ws "$ACTIVE_WS" '.[] | select(.workspace.id == ($ws | tonumber)) | .address')
# CLIENT_COUNT=$(hyprctl clients -j | jq -r '[.[] | select(.workspace.id == 1) | .address] | length')
CLIENT_COUNT=$(echo "$CLIENTS_ACTIVE_ADDR" | wc -l)

#cases swtch to adjust proportions depending on number of clients on WS
case $CLIENT_COUNT in
1)
	exit 0
	;;
2)
	for CLIENT in $CLIENTS_ACTIVE_ADDR; do
		hyprctl dispatch resizewindowpixel exact 50% 100%,address:$CLIENT
	done
	;;
3)
	for CLIENT in $CLIENTS_ACTIVE_ADDR; do
		hyprctl dispatch resizewindowpixel exact 50% 48%,address:$CLIENT
	done
	;;
4)
	for CLIENT in $CLIENTS_ACTIVE_ADDR; do
		hyprctl dispatch resizewindowpixel exact 50% 32%,address:$CLIENT
	done
	;;
5)
	for CLIENT in $CLIENTS_ACTIVE_ADDR; do
		hyprctl dispatch resizewindowpixel exact 50% 24%,address:$CLIENT
	done
	;;
6)
	for CLIENT in $CLIENTS_ACTIVE_ADDR; do
		hyprctl dispatch resizewindowpixel exact 50% 19%,address:$CLIENT
	done
	;;
7)
	# this is already a far fetched edge case and won't get balanced perfectly
	# b/c can't pass floats to a dispatcher
	# but ok let's cover case for 7 clients on the ws in case the madness ensues
	for CLIENT in $CLIENTS_ACTIVE_ADDR; do
		hyprctl dispatch resizewindowpixel exact 50% 15%,address:$CLIENT
	done
	;;
*)
	echo "Client count is outside the damn reasonable range. Close or move some windows IDIOT! XD"
	exit 1
	;;
esac
