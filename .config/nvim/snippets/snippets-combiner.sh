#!/bin/bash

# small utility that will parse standard vscode snippets and combine into one

if [ "$#" -ne 2 ]; then
	echo "Usage: $0 <directory> <scope>"
	exit 1
fi

DIR="$1"
SCOPE="$2"
OUTPUT_FILE="$DIR/$2.code-snippets"

if [ ! -d "$DIR" ]; then
	echo "Error: Directory '$DIR' does not exist."
	exit 1
fi

echo "{" >"$OUTPUT_FILE"

for FILE in "$DIR"/*.json; do
	[ -e "$FILE" ] || continue

	sed '/^\s*\/\//d; /^\s*\/\*/d' "$FILE" | sed '1d;$d' >>"$OUTPUT_FILE"

	echo "," >>"$OUTPUT_FILE"

done

sed -i '$ s/,$//' "$OUTPUT_FILE"

echo "}" >>"$OUTPUT_FILE"
jq --arg scope "$SCOPE" 'to_entries | map({( .key ): (.value + {scope: $scope})}) | add' "$OUTPUT_FILE" >"$OUTPUT_FILE.tmp" && mv "$OUTPUT_FILE.tmp" "$OUTPUT_FILE"

echo "Snippets combined into: $OUTPUT_FILE"
