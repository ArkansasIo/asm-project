; Dragon Warrior-only ca65 NES ROM entry
	.include "constants.inc"
	.include "dragonwarrior/data.asm"
	.include "dragonwarrior/graphics.asm"
	.include "dragonwarrior/sound.asm"
	.include "dragonwarrior/map.asm"
	.include "dragonwarrior/battle.asm"
	.include "dragonwarrior/menu.asm"
	.include "dragonwarrior/main.asm"

.segment "HEADER"
	.byte "N", "E", "S", $1A
	.byte 1
	.byte 1
	.byte 0
	.byte 0
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
