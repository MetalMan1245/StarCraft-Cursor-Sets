#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_DIR="$SCRIPT_DIR/release/Linux"
DEST_DIR="$HOME/.icons"

mkdir -p "$DEST_DIR"

shopt -s nullglob

archives=("$SOURCE_DIR"/*.tar.gz)

if [ ${#archives[@]} -eq 0 ]; then
    echo "No .tar.gz archives found in $SOURCE_DIR"
    exit 1
fi

for archive in "${archives[@]}"; do
    echo "Extracting $(basename "$archive")..."
    tar -xzf "$archive" -C "$DEST_DIR"
done

echo "Extraction complete."
