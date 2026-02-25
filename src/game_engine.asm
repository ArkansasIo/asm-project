; NES Game Engine Core Logic
	.include "constants.inc"

; Game loop entry point
GameLoop:
	JSR Game_Update
	JSR Game_Draw
	JMP GameLoop

; Update game state (player, enemies, etc.)
Game_Update:
	; TODO: Add player, enemy, and game logic here
	RTS

; Draw game state (sprites, background)
Game_Draw:
	; TODO: Add drawing logic here
	RTS
