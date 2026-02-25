; ca65-compatible NES main.asm example
	.include "constants.inc"
	.include "dragonwarrior/data.asm"
	.include "dragonwarrior/graphics.asm"
	.include "dragonwarrior/sound.asm"
	.include "dragonwarrior/map.asm"
	.include "dragonwarrior/battle.asm"
	.include "dragonwarrior/menu.asm"
	.include "dragonwarrior/main.asm"
	.include "dataset.asm"
	.include "types.asm"
	.include "cmos.asm"
	.include "bios.asm"
	.include "game_engine.asm"
	.include "sprite_tile.asm"
	.include "collision.asm"
	.include "editor_tools.asm"
	.include "api.asm"
	.include "ui.asm"
	.include "editor_menu.asm"
	.include "game_menu.asm"
	.include "engine_menu.asm"
	.include "nes_logo.asm"
	.include "game_logo.asm"
	.include "engine_logo.asm"
	.include "titles.asm"
	.include "lib_math.asm"
	.include "lib_string.asm"
	.include "lib_memory.asm"
	.include "lib_graphics.asm"
	.include "lib_sound.asm"
	.include "lib_input.asm"
	.include "lib_data.asm"
	.include "lib_util.asm"

.segment "HEADER"
	.byte "N", "E", "S", $1A ; iNES header
	.byte 1 ; 1x 16KB PRG
	.byte 1 ; 1x 8KB CHR
	.byte 0 ; Mapper, mirroring
	.byte 0 ; Reserved
	.res 8, 0

.segment "STARTUP"
	.org $C000
RESET:
	SEI
	CLD
	LDX #$40
	STX $4017
	LDX #$FF
	TXS
	INX
	STX $2000
	STX $2001
	STX $4010
	JMP DW_Main

Forever:
	JMP Forever

.segment "VECTORS"
	.org $FFFA
	.word NMI
	.word RESET
	.word IRQ

.segment "CODE"
NMI:
	RTI
IRQ:
	RTI
