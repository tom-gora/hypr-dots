#!/bin/sh

my_user=$(echo "$USER@$HOSTNAME" | awk -F'=' '{print toupper($1)}')
echo "$my_user"
