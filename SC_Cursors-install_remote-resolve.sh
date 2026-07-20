#!/bin/bash
set -e

TMPDIR="$(mktemp -d /tmp/SC_Cursors.XXXXXX)"
cleanup() { rm -rf "$TMPDIR"; }
trap cleanup EXIT

echo "[Remote Installer] Creating temp workspace..."
cd "$TMPDIR"

echo "[Remote Installer] Downloading repo..."
curl -fsSL \
  -o repo.zip \
  https://github.com/MetalMan1245/StarCraft-Cursor-Sets/archive/refs/heads/main.zip

echo "[Remote Installer] Extracting..."
unzip -q repo.zip
cd StarCraft-Cursor-Sets-main

echo "[Remote Installer] Running installer..."
chmod +x install_uninstall-SC_Cursors.sh
./install_uninstall-SC_Cursors.sh

echo "[Remote Installer] Done."
