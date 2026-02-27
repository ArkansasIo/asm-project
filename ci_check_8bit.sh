#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BUILD_SCRIPT="$ROOT_DIR/build_8bit.sh"
LOG_FILE="$(mktemp)"
trap 'rm -f "$LOG_FILE"' EXIT

if [[ ! -x "$BUILD_SCRIPT" ]]; then
  echo "Missing executable build script: $BUILD_SCRIPT"
  exit 1
fi

if ! "$BUILD_SCRIPT" 2>&1 | tee "$LOG_FILE"; then
  echo "Build failed."
  exit 1
fi

if grep -Eiq '(^|[[:space:]])warning:' "$LOG_FILE"; then
  echo "Warnings detected; failing strict CI check."
  exit 2
fi

echo "Strict CI check passed (no warnings, no errors)."
