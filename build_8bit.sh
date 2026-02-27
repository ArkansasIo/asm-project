#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC_DIR="$ROOT_DIR/src"
ASM="$SRC_DIR/main_ca65.asm"
OBJ="$SRC_DIR/main_ca65.o"
ROM="$SRC_DIR/main_ca65.nes"
CFG="$SRC_DIR/8bitstudio.cfg"

command -v ca65 >/dev/null 2>&1 || { echo "ca65 not found (install cc65)"; exit 1; }
command -v ld65 >/dev/null 2>&1 || { echo "ld65 not found (install cc65)"; exit 1; }

ca65 "$ASM" -o "$OBJ"
ld65 "$OBJ" -o "$ROM" -C "$CFG"

echo "Build succeeded: $ROM"
