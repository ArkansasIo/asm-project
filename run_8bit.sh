#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROM="$ROOT_DIR/src/main_ca65.nes"

if [[ ! -f "$ROM" ]]; then
  "$ROOT_DIR/build_8bit.sh"
fi

if command -v fceux >/dev/null 2>&1; then
  EMU="$(command -v fceux)"
elif [[ -x /usr/games/fceux ]]; then
  EMU="/usr/games/fceux"
else
  echo "fceux not found (install package: fceux)"
  exit 1
fi

if [[ -z "${DISPLAY:-}" && -z "${WAYLAND_DISPLAY:-}" ]]; then
  echo "No GUI display detected. ROM built at: $ROM"
  echo "Run this script from a desktop session (X11/Wayland) to launch FCEUX."
  exit 0
fi

"$EMU" "$ROM"
