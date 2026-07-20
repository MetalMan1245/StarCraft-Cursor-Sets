#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_DIR="$SCRIPT_DIR/release/Linux"

ICON_DIR="$HOME/.icons"
CONFIG_DIR="$HOME/.config/SC-Cursors"
MANIFEST="$CONFIG_DIR/manifest.txt"

mkdir -p "$ICON_DIR" "$CONFIG_DIR"

shopt -s nullglob

archives=("$SOURCE_DIR"/*.tar.gz)

if [ ${#archives[@]} -eq 0 ]; then
    echo "No .tar.gz archives found in $SOURCE_DIR"
    exit 1
fi

# Extract the archive filename without .tar.gz
archive_names=()
for archive in "${archives[@]}"; do
    archive_names+=("$(basename "$archive" .tar.gz)")
done

uninstall() {
    echo "Uninstalling SC-Cursors..."

    if [[ -f "$MANIFEST" ]]; then
        while IFS= read -r folder; do
            if [[ -d "$ICON_DIR/$folder" ]]; then
                echo "Removing $ICON_DIR/$folder"
                rm -rf "$ICON_DIR/$folder"
            fi
        done < "$MANIFEST"

        rm -f "$MANIFEST"
        rmdir "$CONFIG_DIR" 2>/dev/null || true
    fi

    echo "Uninstall complete."
    exit 0
}

install_archive() {
    local archive="$1"
    local name
    name="$(basename "$archive" .tar.gz)"

    echo "Extracting $(basename "$archive")..."

    tar --warning=no-unknown-keyword \
        -xzf "$archive" \
        -C "$ICON_DIR"

    echo "$name" >> "$MANIFEST"
}

# Existing installation check
if [[ -f "$MANIFEST" ]]; then
    mapfile -t installed_names < "$MANIFEST"

    missing=()

    for name in "${archive_names[@]}"; do
        if ! printf '%s\n' "${installed_names[@]}" | grep -qx "$name"; then
            missing+=("$name")
        fi
    done

    if [[ ${#missing[@]} -eq 0 ]]; then
        read -rp "All SC-Cursors themes are already installed. Uninstall? [y/N] " answer

        case "$answer" in
            y|Y|yes|YES)
                uninstall
                ;;
            *)
                echo "No changes made."
                exit 0
                ;;
        esac
    fi

    echo "Installing new cursor themes..."

    for archive in "${archives[@]}"; do
        name="$(basename "$archive" .tar.gz)"

        if printf '%s\n' "${installed_names[@]}" | grep -qx "$name"; then
            echo "Skipping already installed: $name"
        else
            install_archive "$archive"
        fi
    done

else
    echo "Installing SC-Cursors..."

    : > "$MANIFEST"

    for archive in "${archives[@]}"; do
        install_archive "$archive"
    done
fi

echo "Installation complete."
