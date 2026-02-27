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
  echo "FCEUX not found. Install it on your host machine, then run again."
  exit 1
fi

if [[ -n "${DISPLAY:-}" || -n "${WAYLAND_DISPLAY:-}" ]]; then
  exec "$EMU" "$ROM"
fi

if [[ -n "${WSL_DISTRO_NAME:-}" ]]; then
  echo "No Linux display detected in WSL session."
  echo "Use WSLg (Windows 11) or set DISPLAY to an X server, then run again."
  exit 1
fi

echo "No GUI display detected in this shell."
echo "Run this script from your desktop host terminal/session with X11 or Wayland."
exit 1
