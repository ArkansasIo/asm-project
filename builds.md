# NES Clone Build Scripts

- build_8bit.bat: Builds the 8-bit NES version (main_ca65.asm)
- build_16bit.bat: Builds the 16-bit SNES version (main16.asm, placeholder)

## 8-bit NES
- Uses ca65/ld65 (cc65 toolchain)
- Output: src/main_ca65.nes

## 16-bit SNES (Planned)
- Placeholder for SNES build (use xkas, wla-65816, or ca65 for 65816)
- Output: src16/main16.sfc (or .smc)

Edit build_16bit.bat to match your SNES assembler and linker.
