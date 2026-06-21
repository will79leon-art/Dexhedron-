#!/usr/bin/env bash
# check_signature.sh
# Verify APK signatures and print certificate fingerprints.
# Requirements: apksigner (Android SDK build-tools) or jarsigner + keytool
# Usage: ./android/check_signature.sh path/to/app.apk

set -euo pipefail
APK=${1:-}
if [ -z "$APK" ]; then
  echo "Usage: $0 path/to/app.apk"
  exit 2
fi

if command -v apksigner >/dev/null 2>&1; then
  echo "Using apksigner to print certs"
  apksigner verify --print-certs "$APK"
else
  echo "apksigner not found; attempting jarsigner + keytool"
  jarsigner -verify -verbose -certs "$APK" || true
fi

if command -v keytool >/dev/null 2>&1; then
  echo "To compare fingerprints, run: keytool -list -v -keystore my-release-key.keystore"
fi
