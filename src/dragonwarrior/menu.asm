; Dragon Warrior Clone - Menu System

.segment "CODE"

DW_MenuLoop:
    ; Route to the active menu mode.
    LDA DW_BattleActive
    BEQ :field
    LDA #DW_MENU_MODE_BATTLE
    STA DW_MenuMode
    JMP DW_BattleLoop

:field:
    LDA DW_MenuMode
    CMP #DW_MENU_MODE_COMMAND
    BEQ DW_CommandMenu_HandleInput
    CMP #DW_MENU_MODE_SUBMENU_SPELL
    BEQ DW_SpellSubmenu_HandleInput
    CMP #DW_MENU_MODE_SUBMENU_ITEM
    BEQ DW_ItemSubmenu_HandleInput

    ; Field mode: START opens command menu.
    LDA DW_InputPressed
    AND #DW_BTN_START
    BEQ :done
    LDA #DW_MENU_MODE_COMMAND
    STA DW_MenuMode
    LDA #0
    STA DW_CommandMenuIndex
    JSR DW_CommandMenu_Draw
:done:
    RTS

DW_CommandMenu_Draw:
    ; UI integration point.
    LDA #18
    STA DW_MessageId
    RTS

DW_CommandMenu_HandleInput:
    LDA DW_InputPressed
    AND #DW_BTN_UP
    BEQ :checkDown
    LDA DW_CommandMenuIndex
    BEQ :checkDown
    DEC DW_CommandMenuIndex
    RTS
:checkDown:
    LDA DW_InputPressed
    AND #DW_BTN_DOWN
    BEQ :checkA
    LDA DW_CommandMenuIndex
    CMP #7
    BCS :checkA
    INC DW_CommandMenuIndex
    RTS
:checkA:
    LDA DW_InputPressed
    AND #DW_BTN_A
    BEQ :checkB
    JSR DW_CommandMenu_Execute
    RTS
:checkB:
    LDA DW_InputPressed
    AND #DW_BTN_B
    BEQ :done
    LDA #DW_MENU_MODE_FIELD
    STA DW_MenuMode
:done:
    RTS

DW_CommandMenu_Execute:
    LDA DW_CommandMenuIndex
    BEQ DW_FieldTalk
    CMP #1
    BEQ DW_CommandMenu_OpenSpellSubmenu
    CMP #2
    BEQ DW_CommandMenu_ShowStatus
    CMP #3
    BEQ DW_CommandMenu_OpenItemSubmenu
    CMP #4
    BEQ DW_FieldSearch
    CMP #5
    BEQ DW_FieldUseStairs
    CMP #6
    BEQ DW_FieldOpenDoor
    JMP DW_FieldTake

DW_CommandMenu_OpenSpellSubmenu:
    LDA #DW_MENU_MODE_SUBMENU_SPELL
    STA DW_MenuMode
    LDA #0
    STA DW_SubmenuIndex
    RTS

DW_CommandMenu_OpenItemSubmenu:
    LDA #DW_MENU_MODE_SUBMENU_ITEM
    STA DW_MenuMode
    LDA #0
    STA DW_SubmenuIndex
    RTS

DW_CommandMenu_ShowStatus:
    ; Message-only status hook for now.
    LDA #19
    STA DW_MessageId
    RTS

DW_SpellSubmenu_HandleInput:
    LDA DW_InputPressed
    AND #DW_BTN_UP
    BEQ :checkDown
    LDA DW_SubmenuIndex
    BEQ :checkDown
    DEC DW_SubmenuIndex
    RTS
:checkDown:
    LDA DW_InputPressed
    AND #DW_BTN_DOWN
    BEQ :checkA
    LDA DW_SubmenuIndex
    CMP #3
    BCS :checkA
    INC DW_SubmenuIndex
    RTS
:checkA:
    LDA DW_InputPressed
    AND #DW_BTN_A
    BEQ :checkB
    JSR DW_SpellSubmenu_UseSelected
    RTS
:checkB:
    LDA DW_InputPressed
    AND #DW_BTN_B
    BEQ :done
    LDA #DW_MENU_MODE_COMMAND
    STA DW_MenuMode
:done:
    RTS

DW_SpellSubmenu_UseSelected:
    LDA DW_SubmenuIndex
    BEQ DW_SpellCastHeal
    CMP #1
    BEQ DW_SpellCastHurt
    CMP #2
    BEQ DW_SpellCastSleep
    JMP DW_SpellCastRadiant

DW_SpellCastHeal:
    LDA DW_HasSpellHeal
    BEQ :fail
    LDA DW_PlayerMP
    CMP #3
    BCC :fail
    SEC
    SBC #3
    STA DW_PlayerMP
    LDA DW_PlayerHP
    CLC
    ADC #10
    CMP DW_PlayerMaxHP
    BCC :store
    LDA DW_PlayerMaxHP
:store:
    STA DW_PlayerHP
    LDA #20
    STA DW_MessageId
    RTS
:fail:
    LDA #21
    STA DW_MessageId
    RTS

DW_SpellCastHurt:
    ; In field mode, Hurt has no effect; in battle it's handled by battle logic.
    LDA DW_BattleActive
    BEQ :fieldNoEffect
    JMP DW_BattleSpell
:fieldNoEffect:
    LDA #22
    STA DW_MessageId
    RTS

DW_SpellCastSleep:
    LDA DW_HasSpellSleep
    BEQ :fail
    LDA DW_PlayerMP
    CMP #2
    BCC :fail
    SEC
    SBC #2
    STA DW_PlayerMP
    LDA #23
    STA DW_MessageId
    RTS
:fail:
    LDA #21
    STA DW_MessageId
    RTS

DW_SpellCastRadiant:
    LDA DW_HasSpellRadiant
    BEQ :fail
    LDA DW_PlayerMP
    CMP #2
    BCC :fail
    SEC
    SBC #2
    STA DW_PlayerMP
    LDA #24
    STA DW_MessageId
    RTS
:fail:
    LDA #21
    STA DW_MessageId
    RTS

DW_ItemSubmenu_HandleInput:
    LDA DW_InputPressed
    AND #DW_BTN_UP
    BEQ :checkDown
    LDA DW_SubmenuIndex
    BEQ :checkDown
    DEC DW_SubmenuIndex
    RTS
:checkDown:
    LDA DW_InputPressed
    AND #DW_BTN_DOWN
    BEQ :checkA
    LDA DW_SubmenuIndex
    CMP #3
    BCS :checkA
    INC DW_SubmenuIndex
    RTS
:checkA:
    LDA DW_InputPressed
    AND #DW_BTN_A
    BEQ :checkB
    JSR DW_ItemSubmenu_UseSelected
    RTS
:checkB:
    LDA DW_InputPressed
    AND #DW_BTN_B
    BEQ :done
    LDA #DW_MENU_MODE_COMMAND
    STA DW_MenuMode
:done:
    RTS

DW_ItemSubmenu_UseSelected:
    LDA DW_SubmenuIndex
    BEQ DW_ItemUseHerb
    CMP #1
    BEQ DW_ItemUseKey
    CMP #2
    BEQ DW_ItemUseTorch
    JMP DW_ItemUseWing

DW_ItemUseHerb:
    LDA DW_InventoryHerb
    BEQ :fail
    DEC DW_InventoryHerb
    LDA DW_PlayerHP
    CLC
    ADC #8
    CMP DW_PlayerMaxHP
    BCC :storeHP
    LDA DW_PlayerMaxHP
:storeHP:
    STA DW_PlayerHP
    LDA #25
    STA DW_MessageId
    RTS
:fail:
    LDA #12
    STA DW_MessageId
    RTS

DW_ItemUseKey:
    JMP DW_FieldOpenDoor

DW_ItemUseTorch:
    LDA DW_InventoryTorch
    BEQ :fail
    DEC DW_InventoryTorch
    LDA #26
    STA DW_MessageId
    RTS
:fail:
    LDA #12
    STA DW_MessageId
    RTS

DW_ItemUseWing:
    LDA DW_InventoryWing
    BEQ :fail
    DEC DW_InventoryWing
    LDA #0
    STA DW_PlayerX
    STA DW_PlayerY
    LDA #27
    STA DW_MessageId
    RTS
:fail:
    LDA #12
    STA DW_MessageId
    RTS
