; SNES 16-bit Submenu System (Settings, About, etc.)
.segment "CODE"
SubMenu16:
	; Draw submenu (placeholder)
	JSR DrawSubMenu16
	; Handle input (placeholder)
	JSR HandleSubMenuInput16
	RTS

DrawSubMenu16:
	; TODO: Draw submenu options
	RTS

HandleSubMenuInput16:
	; TODO: Read controller, update selection, call actions
	RTS
