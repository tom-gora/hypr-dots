#!/usr/bin/env bash

# set -x
set -eEu

REPOS=(
	"https://github.com/tom-gora/rofiQuickColors.git"
	"https://github.com/tom-gora/gophi.git"
)

BACKENDS_DIR="/tmp/rofi-backend"
BIN_DIR="$HOME/.config/rofi/backend/bin"

get_bin() {
	REPO_URL="$1"
	CLONED_REPO=$(basename "$REPO_URL" .git)

	echo "Cloning $CLONED_REPO..."

	if ! git clone -q "$REPO_URL" "$BACKENDS_DIR/$CLONED_REPO" >/dev/null 2>&1; then
		echo "Failed to clone $CLONED_REPO"
		return 1
	fi

	pushd "$BACKENDS_DIR/$CLONED_REPO" >/dev/null

	ENTRY_PATH=$(find . -name "main.go" -print -quit)

	if [ -z "$ENTRY_PATH" ]; then
		echo "No main.go found for $CLONED_REPO"
		popd >/dev/null
		return 1
	fi

	go build "$ENTRY_PATH"

	if [ -z "$ENTRY_PATH" ]; then
		echo "No main.go found for $CLONED_REPO"
		popd >/dev/null
		return 1
	fi

	BINARY_NAME=$(basename "$CLONED_REPO")
	go build -o "$BINARY_NAME" "$ENTRY_PATH"

	if ! go build -o "$BINARY_NAME" "$ENTRY_PATH"; then
		echo "Failed to build $CLONED_REPO"
		popd >/dev/null
		return 1
	fi

	mv "$BINARY_NAME" "$BIN_DIR/$BINARY_NAME"

	echo "Cloned and built $CLONED_REPO"
	popd >/dev/null
	return 0
}

mkdir -p "$BACKENDS_DIR"
mkdir -p "$BIN_DIR"

for REPO in "${REPOS[@]}"; do
	get_bin "$REPO"
done

rm -rf "$BACKENDS_DIR"
