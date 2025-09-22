#!/bin/env bash

name=$(ollama ps | sed -n '2p' | awk '{ print $1 }')

if [ -z "$name" ]; then
	echo ""
	exit 0
fi
echo " $name   "
exit 0
