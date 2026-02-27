; Dragon Warrior Clone - Battle System

.segment "CODE"

DW_BattleStart:
    LDA #1
    STA DW_BattleActive
    LDA #0
    STA DW_BattleMenuIndex
    ; Spawn a baseline enemy.
    LDA #8
    STA DW_EnemyHP
    STA DW_EnemyMaxHP
    LDA #2
    STA DW_EnemyStr
    LDA #1
    STA DW_EnemyAgi
    LDA #9
    STA DW_MessageId
    RTS

DW_BattleLoop:
    LDA DW_BattleActive
    BEQ @done
    JSR DW_BattleHandleInput
@done:
    RTS

DW_BattleHandleInput:
    LDA DW_InputPressed
    AND #DW_BTN_UP
    BEQ @checkDown
    LDA DW_BattleMenuIndex
    BEQ @checkDown
    DEC DW_BattleMenuIndex
    RTS
@checkDown:
    LDA DW_InputPressed
    AND #DW_BTN_DOWN
    BEQ @checkA
    LDA DW_BattleMenuIndex
    CMP #4
    BCS @checkA
    INC DW_BattleMenuIndex
    RTS
@checkA:
    LDA DW_InputPressed
    AND #DW_BTN_A
    BEQ @checkB
    JSR DW_BattleExecuteSelection
    RTS
@checkB:
    LDA DW_InputPressed
    AND #DW_BTN_B
    BEQ @done
    ; B defaults to parry.
    JSR DW_BattleParry
@done:
    RTS

DW_BattleExecuteSelection:
    LDA DW_BattleMenuIndex
    BNE :+
    JMP DW_BattleFight
:
    CMP #1
    BNE :+
    JMP DW_BattleSpell
:
    CMP #2
    BNE :+
    JMP DW_BattleItem
:
    CMP #3
    BNE :+
    JMP DW_BattleRun
:
    JMP DW_BattleParry

DW_BattleFight:
    ; Damage = 1 + (STR/2) + low random bits.
    LDA DW_PlayerStr
    LSR A
    CLC
    ADC #1
    STA DW_ActionResult
    JSR DW_RngNext
    LDA DW_RngState
    AND #$03
    CLC
    ADC DW_ActionResult
    STA DW_ActionResult

    LDA DW_EnemyHP
    SEC
    SBC DW_ActionResult
    BCS @storeEnemy
    LDA #0
@storeEnemy:
    STA DW_EnemyHP
    BEQ @victory

    JSR DW_BattleEnemyTurn
    RTS

@victory:
    JSR DW_BattleOnVictory
    RTS

DW_BattleSpell:
    ; Default battle spell is HURT if known.
    LDA DW_HasSpellHurt
    BEQ @fail
    LDA DW_PlayerMP
    CMP #2
    BCC @fail
    SEC
    SBC #2
    STA DW_PlayerMP
    JSR DW_RngNext
    LDA DW_RngState
    AND #$03
    CLC
    ADC #3
    STA DW_ActionResult
    LDA DW_EnemyHP
    SEC
    SBC DW_ActionResult
    BCS @storeEnemy
    LDA #0
@storeEnemy:
    STA DW_EnemyHP
    BEQ @victory
    JSR DW_BattleEnemyTurn
    RTS
@victory:
    JSR DW_BattleOnVictory
    RTS
@fail:
    LDA #10
    STA DW_MessageId
    RTS

DW_BattleItem:
    ; Use herb if available.
    LDA DW_InventoryHerb
    BEQ @fail
    DEC DW_InventoryHerb
    LDA DW_PlayerHP
    CLC
    ADC #8
    CMP DW_PlayerMaxHP
    BCC @storeHP
    LDA DW_PlayerMaxHP
@storeHP:
    STA DW_PlayerHP
    LDA #11
    STA DW_MessageId
    JSR DW_BattleEnemyTurn
    RTS
@fail:
    LDA #12
    STA DW_MessageId
    RTS

DW_BattleRun:
    JSR DW_RngNext
    LDA DW_RngState
    AND #$03
    BEQ @fail
    LDA #0
    STA DW_BattleActive
    LDA #13
    STA DW_MessageId
    RTS
@fail:
    LDA #14
    STA DW_MessageId
    JSR DW_BattleEnemyTurn
    RTS

DW_BattleParry:
    ; Half damage taken this turn.
    LDA #15
    STA DW_MessageId
    JSR DW_BattleEnemyTurnParried
    RTS

DW_BattleEnemyTurn:
    ; Damage = 1 + enemy STR + random(0..1).
    JSR DW_RngNext
    LDA DW_RngState
    AND #1
    CLC
    ADC #1
    CLC
    ADC DW_EnemyStr
    STA DW_ActionResult
    JMP DW_BattleApplyDamage

DW_BattleEnemyTurnParried:
    JSR DW_RngNext
    LDA DW_RngState
    AND #1
    CLC
    ADC DW_EnemyStr
    LSR A
    STA DW_ActionResult
    JMP DW_BattleApplyDamage

DW_BattleApplyDamage:
    LDA DW_PlayerHP
    SEC
    SBC DW_ActionResult
    BCS @store
    LDA #0
@store:
    STA DW_PlayerHP
    BNE @done
    JSR DW_BattleOnDefeat
@done:
    RTS

DW_BattleOnVictory:
    LDA #0
    STA DW_BattleActive
    CLC
    LDA DW_PlayerXPLo
    ADC #3
    STA DW_PlayerXPLo
    LDA DW_PlayerXPHi
    ADC #0
    STA DW_PlayerXPHi
    CLC
    LDA DW_PlayerGoldLo
    ADC #5
    STA DW_PlayerGoldLo
    LDA DW_PlayerGoldHi
    ADC #0
    STA DW_PlayerGoldHi
    LDA #16
    STA DW_MessageId
    RTS

DW_BattleOnDefeat:
    ; Keep prototype simple: restore and send player to start.
    LDA DW_PlayerMaxHP
    STA DW_PlayerHP
    LDA DW_PlayerMaxMP
    STA DW_PlayerMP
    LDA #0
    STA DW_PlayerX
    STA DW_PlayerY
    STA DW_BattleActive
    LDA #17
    STA DW_MessageId
    RTS
