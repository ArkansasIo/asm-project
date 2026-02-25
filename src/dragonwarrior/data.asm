; Dragon Warrior Clone - Game Data

DW_BTN_A      = %00000001
DW_BTN_B      = %00000010
DW_BTN_SELECT = %00000100
DW_BTN_START  = %00001000
DW_BTN_UP     = %00010000
DW_BTN_DOWN   = %00100000
DW_BTN_LEFT   = %01000000
DW_BTN_RIGHT  = %10000000

DW_DIR_UP     = 0
DW_DIR_DOWN   = 1
DW_DIR_LEFT   = 2
DW_DIR_RIGHT  = 3

DW_MENU_MODE_FIELD         = 0
DW_MENU_MODE_COMMAND       = 1
DW_MENU_MODE_SUBMENU_SPELL = 2
DW_MENU_MODE_SUBMENU_ITEM  = 3
DW_MENU_MODE_BATTLE        = 4

.segment "RODATA"
DW_CommandMenuText:
    .byte "TALK",0
    .byte "SPELL",0
    .byte "STATUS",0
    .byte "ITEM",0
    .byte "SEARCH",0
    .byte "STAIRS",0
    .byte "DOOR",0
    .byte "TAKE",0

DW_BattleMenuText:
    .byte "FIGHT",0
    .byte "SPELL",0
    .byte "ITEM",0
    .byte "RUN",0
    .byte "PARRY",0

DW_SpellNames:
    .byte "HEAL",0
    .byte "HURT",0
    .byte "SLEEP",0
    .byte "RADIANT",0

DW_ItemNames:
    .byte "HERB",0
    .byte "KEY",0
    .byte "TORCH",0
    .byte "WING",0

.segment "RAM"
DW_PlayerHP:          .res 1
DW_PlayerMP:          .res 1
DW_PlayerMaxHP:       .res 1
DW_PlayerMaxMP:       .res 1
DW_PlayerLevel:       .res 1
DW_PlayerGoldLo:      .res 1
DW_PlayerGoldHi:      .res 1
DW_PlayerXPLo:        .res 1
DW_PlayerXPHi:        .res 1
DW_PlayerStr:         .res 1
DW_PlayerAgi:         .res 1

DW_PlayerX:           .res 1
DW_PlayerY:           .res 1
DW_PlayerDir:         .res 1

DW_MapId:             .res 1
DW_TileUnderPlayer:   .res 1
DW_LastTileInteracted:.res 1

DW_EnemyHP:           .res 1
DW_EnemyMaxHP:        .res 1
DW_EnemyStr:          .res 1
DW_EnemyAgi:          .res 1
DW_EnemyId:           .res 1

DW_BattleActive:      .res 1
DW_BattleMenuIndex:   .res 1
DW_CommandMenuIndex:  .res 1
DW_SubmenuIndex:      .res 1
DW_MenuMode:          .res 1

DW_InputHeld:         .res 1
DW_InputPressed:      .res 1
DW_InputPrev:         .res 1

DW_MessageId:         .res 1
DW_ActionResult:      .res 1
DW_RngState:          .res 1

DW_InventoryHerb:     .res 1
DW_InventoryKey:      .res 1
DW_InventoryTorch:    .res 1
DW_InventoryWing:     .res 1

DW_HasSpellHeal:      .res 1
DW_HasSpellHurt:      .res 1
DW_HasSpellSleep:     .res 1
DW_HasSpellRadiant:   .res 1

.segment "CODE"
DW_DataInit:
    LDA #20
    STA DW_PlayerHP
    STA DW_PlayerMaxHP
    LDA #8
    STA DW_PlayerMP
    STA DW_PlayerMaxMP
    LDA #1
    STA DW_PlayerLevel
    STA DW_PlayerStr
    STA DW_PlayerAgi
    STA DW_InventoryHerb
    LDA #0
    STA DW_PlayerGoldLo
    STA DW_PlayerGoldHi
    STA DW_PlayerXPLo
    STA DW_PlayerXPHi
    STA DW_PlayerX
    STA DW_PlayerY
    STA DW_MapId
    STA DW_BattleActive
    STA DW_CommandMenuIndex
    STA DW_BattleMenuIndex
    STA DW_SubmenuIndex
    STA DW_MenuMode
    STA DW_MessageId
    STA DW_ActionResult
    STA DW_InputHeld
    STA DW_InputPressed
    STA DW_InputPrev
    STA DW_LastTileInteracted
    LDA #$5A
    STA DW_RngState

    ; Starter spell set for prototype gameplay.
    LDA #1
    STA DW_HasSpellHeal
    STA DW_HasSpellHurt
    LDA #0
    STA DW_HasSpellSleep
    STA DW_HasSpellRadiant

    ; Basic enemy defaults (slime-like).
    LDA #8
    STA DW_EnemyHP
    STA DW_EnemyMaxHP
    LDA #1
    STA DW_EnemyStr
    STA DW_EnemyAgi
    LDA #0
    STA DW_EnemyId
    RTS

DW_RngNext:
    ; Very small LCG-style step. Good enough for placeholder combat rolls.
    LDA DW_RngState
    ASL A
    ADC #$13
    EOR #$A7
    STA DW_RngState
    RTS
