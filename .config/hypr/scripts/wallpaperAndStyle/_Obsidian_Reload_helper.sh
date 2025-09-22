#!/bin/bash

URIS=("obsidian://adv-uri?commandname=Save%20current%20file" "obsidian://adv-uri?commandname=Reload%20app%20without%20saving")

for uri in "${URIS[@]}"; do
  xdg-open "$uri"
  if [ $? -ne 0 ]; then
    exit 1
  fi
  sleep 0.5
done

exit 0
