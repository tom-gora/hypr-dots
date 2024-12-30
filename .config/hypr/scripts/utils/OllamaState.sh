#!/bin/bash

OLLAMA_PID=$(pgrep -f 'ollama')

if [ -n "$OLLAMA_PID" ]; then
	echo "        <span font-size='x-small' rise='5pt' font-weight='bold'>✓</span>"
else
	echo "        <span font-size='x-small' rise='5pt' font-weight='bold'></span>"
fi
