; Editor Menu System
	.include "constants.inc"

; Draw editor main menu
EditorMenu_Draw:
	JSR UI_DrawMenuBox
	JSR UI_DrawButton ; e.g., "Edit Tiles"
	JSR UI_DrawButton ; e.g., "Save Level"
	JSR UI_DrawButton ; e.g., "Load Level"
	RTS

; Handle editor menu input
EditorMenu_HandleInput:
	; TODO: Read controller, update selection, call actions
	RTS
