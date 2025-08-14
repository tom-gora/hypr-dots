#!/bin/env bash

OLLAMA_PID=$(pgrep -f 'ollama')

if [ -n "$OLLAMA_PID" ]; then
	echo "      <span font-size='small' rise='12pt' font-weight='bold'>✓</span>"
else
	echo "      <span font-size='small' rise='12pt' font-weight='bold'></span>"
fi
