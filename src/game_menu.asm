; Game Menu System
	.include "constants.inc"

; Draw game pause menu
GameMenu_Draw:
	JSR UI_DrawMenuBox
	JSR UI_DrawButton ; e.g., "Resume"
	JSR UI_DrawButton ; e.g., "Restart"
	JSR UI_DrawButton ; e.g., "Quit"
	RTS

; Handle game menu input
GameMenu_HandleInput:
	; TODO: Read controller, update selection, call actions
	RTS
