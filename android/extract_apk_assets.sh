#!/usr/bin/env bash
# extract_apk_assets.sh
# Pull installed APKs from a connected Android device via adb and extract their resources.
# Requirements: adb, apktool, unzip, jadx (optional)
# Usage: ./android/extract_apk_assets.sh /path/to/output

set -euo pipefail
OUTDIR=${1:-$(pwd)/apk-extract}
mkdir -p "$OUTDIR"

echo "Listing installed packages (user)"
adb shell pm list packages -3 -f > "$OUTDIR/packages.txt"

cd "$OUTDIR"
while IFS= read -r line; do
  # line format: package:/data/app/.../base.apk=com.example.app
  apk_path=$(echo "$line" | sed -n 's/^package:\(.*\)=.*/\1/p')
  pkg_name=$(echo "$line" | sed -n 's/^.*=\(.*\)$/\1/p')
  if [ -z "$apk_path" ] || [ -z "$pkg_name" ]; then
    continue
  fi
  echo "Pulling $pkg_name from device: $apk_path"
  adb pull "$apk_path" "$pkg_name.apk" || echo "Failed to pull $apk_path"
  if [ -f "$pkg_name.apk" ]; then
    mkdir -p "${pkg_name}_unpacked"
    echo "Extracting $pkg_name.apk"
    unzip -q "$pkg_name.apk" -d "${pkg_name}_unpacked"
    if command -v apktool >/dev/null 2>&1; then
      echo "Running apktool for $pkg_name.apk"
      apktool d -f "$pkg_name.apk" -o "${pkg_name}_apktool"
    fi
    if command -v jadx >/dev/null 2>&1; then
      echo "Running jadx for $pkg_name.apk (may be slow)"
      mkdir -p "${pkg_name}_jadx" && jadx -d "${pkg_name}_jadx" "$pkg_name.apk" || true
    fi
  fi
done < "$OUTDIR/packages.txt"

echo "Done. Extracted APKs and resources in $OUTDIR"
