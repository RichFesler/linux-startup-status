#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
SOURCE_CORE="$REPO_DIR/linux-startup-status"
SOURCE_VIEWER="$REPO_DIR/scripts/linux-startup-status-viewer"
SOURCE_DESKTOP="$REPO_DIR/desktop/linux-startup-status-viewer.desktop"

TARGET_MOTD="/etc/update-motd.d/99-linux-startup-status"
TARGET_CORE="/usr/local/bin/linux-startup-status"
TARGET_VIEWER="/usr/local/bin/linux-startup-status-viewer"
TARGET_DESKTOP="/usr/local/share/applications/linux-startup-status-viewer.desktop"

if [ "${EUID}" -ne 0 ]; then
  exec sudo "$0" "$@"
fi

install -d /etc/update-motd.d /usr/local/bin /usr/local/share/applications
install -m 0755 "$SOURCE_CORE" "$TARGET_MOTD"
install -m 0755 "$SOURCE_CORE" "$TARGET_CORE"
install -m 0755 "$SOURCE_VIEWER" "$TARGET_VIEWER"
install -m 0644 "$SOURCE_DESKTOP" "$TARGET_DESKTOP"

printf 'Installed:\n'
printf '  %s\n' "$TARGET_MOTD" "$TARGET_CORE" "$TARGET_VIEWER" "$TARGET_DESKTOP"
printf '\nPreview:\n\n'
"$TARGET_CORE" || true
