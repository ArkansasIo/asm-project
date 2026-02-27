; Dragon Warrior Clone - Map System

.segment "CODE"

DW_MapLoop:
    JSR DW_FieldHandleMovement
    JSR DW_FieldCheckEncounter
    RTS

DW_FieldHandleMovement:
    LDA DW_InputPressed
    AND #DW_BTN_UP
    BEQ :+
    LDA #DW_DIR_UP
    STA DW_PlayerDir
    DEC DW_PlayerY
    RTS
:
    LDA DW_InputPressed
    AND #DW_BTN_DOWN
    BEQ :+
    LDA #DW_DIR_DOWN
    STA DW_PlayerDir
    INC DW_PlayerY
    RTS
:
    LDA DW_InputPressed
    AND #DW_BTN_LEFT
    BEQ :+
    LDA #DW_DIR_LEFT
    STA DW_PlayerDir
    DEC DW_PlayerX
    RTS
:
    LDA DW_InputPressed
    AND #DW_BTN_RIGHT
    BEQ :+
    LDA #DW_DIR_RIGHT
    STA DW_PlayerDir
    INC DW_PlayerX
:
    RTS

DW_FieldCheckEncounter:
    ; 1/8 chance after movement button input.
    LDA DW_InputPressed
    AND #(DW_BTN_UP | DW_BTN_DOWN | DW_BTN_LEFT | DW_BTN_RIGHT)
    BEQ @done
    JSR DW_RngNext
    LDA DW_RngState
    AND #$07
    BNE @done
    JSR DW_BattleStart
@done:
    RTS

DW_FieldTalk:
    ; Placeholder talk interaction.
    LDA #1
    STA DW_MessageId
    LDA #1
    STA DW_ActionResult
    RTS

DW_FieldSearch:
    ; Small chance to find 1 gold.
    JSR DW_RngNext
    LDA DW_RngState
    AND #$03
    BNE @notFound
    INC DW_PlayerGoldLo
    BNE :+
    INC DW_PlayerGoldHi
:
    LDA #2
    STA DW_MessageId
    LDA #1
    STA DW_ActionResult
    RTS
@notFound:
    LDA #3
    STA DW_MessageId
    LDA #0
    STA DW_ActionResult
    RTS

DW_FieldUseStairs:
    ; Toggle between map 0 and 1 for prototype dungeon transitions.
    LDA DW_MapId
    EOR #1
    STA DW_MapId
    LDA #4
    STA DW_MessageId
    LDA #1
    STA DW_ActionResult
    RTS

DW_FieldOpenDoor:
    LDA DW_InventoryKey
    BEQ @noKey
    DEC DW_InventoryKey
    LDA #5
    STA DW_MessageId
    LDA #1
    STA DW_ActionResult
    RTS
@noKey:
    LDA #6
    STA DW_MessageId
    LDA #0
    STA DW_ActionResult
    RTS

DW_FieldTake:
    ; Simple chest/take action: random herb or key.
    JSR DW_RngNext
    LDA DW_RngState
    AND #1
    BEQ @herb
    INC DW_InventoryKey
    LDA #7
    STA DW_MessageId
    LDA #1
    STA DW_ActionResult
    RTS
@herb:
    INC DW_InventoryHerb
    LDA #8
    STA DW_MessageId
    LDA #1
    STA DW_ActionResult
    RTS
