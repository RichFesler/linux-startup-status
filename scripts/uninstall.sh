#!/usr/bin/env bash
set -euo pipefail

TARGET_MOTD="/etc/update-motd.d/99-linux-startup-status"
TARGET_CORE="/usr/local/bin/linux-startup-status"
TARGET_VIEWER="/usr/local/bin/linux-startup-status-viewer"
TARGET_DESKTOP="/usr/local/share/applications/linux-startup-status-viewer.desktop"

if [ "${EUID}" -ne 0 ]; then
  exec sudo "$0" "$@"
fi

rm -f "$TARGET_MOTD" "$TARGET_CORE" "$TARGET_VIEWER" "$TARGET_DESKTOP"
printf 'Removed:\n'
printf '  %s\n' "$TARGET_MOTD" "$TARGET_CORE" "$TARGET_VIEWER" "$TARGET_DESKTOP"
