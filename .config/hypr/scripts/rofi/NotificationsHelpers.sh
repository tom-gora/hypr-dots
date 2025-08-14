#!/bin/env bash

format_message() {
	local input_message="$1"
	local input_length=${#input_message}
	local max_length=60
	local formatted_output=""
	local current_line_length=0
	local word=""

	if ((input_length <= max_length)); then
		formatted_output="$input_message"
		echo "$formatted_output" # Output the formatted text
		return                   # exit the function
	fi

	for word in $input_message; do
		if ((current_line_length + ${#word} + (current_line_length > 0 ? 1 : 0) > max_length)) && ((current_line_length > 0)); then
			formatted_output+="\n"
			current_line_length=0
		elif [[ -n "$formatted_output" ]] && ((current_line_length > 0)); then
			formatted_output+=" "
			current_line_length=$((current_line_length + 1))
		fi

		formatted_output+="$word"
		current_line_length+=${#word}
	done

	echo "$formatted_output"
}
