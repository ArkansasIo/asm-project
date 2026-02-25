; 8BitStudio Editor Tools and Functions
	.include "constants.inc"

; Move editor cursor
Editor_CursorMove:
	; TODO: Move cursor in editor
	RTS
	
.segment "EDITORTOOLS"
EditorTools:
	; Map editing routines
	; Example: Move cursor, select tile
	JSR Editor_MoveCursor
	JSR Editor_SelectTile
	; Tile placement
	JSR Editor_PlaceTile
	; Event scripting
	JSR Editor_EditEvent
	RTS

; Move cursor in editor
Editor_MoveCursor:
	; TODO: Read input, update cursor position
	RTS

; Select tile from palette
Editor_SelectTile:
	; TODO: Highlight tile, store selection
	RTS

; Place tile on map
Editor_PlaceTile:
	; TODO: Write tile to map data
	RTS

; Edit event at cursor
Editor_EditEvent:
	; TODO: Open event editor, modify event data
	RTS

; Place tile at cursor
Editor_PlaceTile:
	; TODO: Write tile to level data
	RTS

; Remove tile at cursor
Editor_RemoveTile:
	; TODO: Remove tile from level data
	RTS

; Save level to CMOS RAM
Editor_SaveLevel:
	; TODO: Copy level data to CMOS
	RTS

; Load level from CMOS RAM
Editor_LoadLevel:
	; TODO: Copy CMOS data to level RAM
	RTS
