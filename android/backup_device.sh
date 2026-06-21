#!/usr/bin/env bash
# backup_device.sh
# Create a simple file dump of an Android device's user-accessible storage.
# WARNING: Modern Android versions limit adb backup and app data access.
# Requirements: adb
# Usage: ./android/backup_device.sh /path/to/output

set -euo pipefail
OUTDIR=${1:-$(pwd)/device-backup}
mkdir -p "$OUTDIR"

echo "Checking device"
adb devices

echo "Pulling /sdcard contents"
adb pull /sdcard "$OUTDIR/sdcard" || echo "Failed to pull /sdcard"

# Attempt legacy backup (may fail on modern devices)
if adb backup -help >/dev/null 2>&1; then
  echo "Attempting legacy adb backup (may not work on modern devices)"
  adb backup -apk -all -f "$OUTDIR/apps.ab" || echo "adb backup failed or was denied"
fi

echo "Backup completed to $OUTDIR"
