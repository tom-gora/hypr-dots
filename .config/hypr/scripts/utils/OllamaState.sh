#!/bin/env bash

OLLAMA_PID=$(pgrep -f 'ollama')

if [ -n "$OLLAMA_PID" ]; then
	echo "      <span font-size='4pt' rise='10pt' font-weight='bold'>✓</span>"
else
	echo "      <span font-size='4pt' rise='10pt' font-weight='bold'></span>"
fi
