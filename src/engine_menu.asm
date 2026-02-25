; Game Engine Menu System
	.include "constants.inc"

; Draw main game engine menu (title screen, etc.)
EngineMenu_Draw:
	JSR UI_DrawMenuBox
	JSR UI_DrawButton ; e.g., "Start Game"
	JSR UI_DrawButton ; e.g., "Options"
	JSR UI_DrawButton ; e.g., "Credits"
	RTS

; Handle engine menu input
EngineMenu_HandleInput:
	; TODO: Read controller, update selection, call actions
	RTS
