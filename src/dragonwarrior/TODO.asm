; Dragon Warrior Clone - Implementation TODO List
; This file is a source-level roadmap for missing features and required ASM work.
; Check items off as routines/files are completed.

; ============================================================
; PHASE 1 - CORE PLAYABLE LOOP (HIGHEST PRIORITY)
; ============================================================
; [ ] Add real overworld map data and tile collision tables.
; [ ] Block movement into solid tiles (walls, water, mountains).
; [ ] Add NPC and sign interaction lookup for TALK command.
; [ ] Add chest and searchable tile event tables for SEARCH/TAKE.
; [ ] Add door tile states (closed/open) with key consumption.
; [ ] Add stairs tile transitions between maps/floors.
; [ ] Add game-state mode switching (title, field, battle, text box).
; [ ] Add deterministic frame-step update order to avoid input race issues.

; New files to create:
; [ ] map_data.asm          ; overworld/town/dungeon tilemaps
; [ ] map_collision.asm     ; passability bits and tile behavior flags
; [ ] map_events.asm        ; NPC/sign/chest/door/stairs event tables

; ============================================================
; PHASE 2 - UI, TEXT, MENUS, SUBMENUS
; ============================================================
; [ ] Implement nametable text renderer (8x8 font tile writing).
; [ ] Implement text window box drawing and line wrapping.
; [ ] Implement message queue/state machine for scripted text.
; [ ] Draw command menu cursor and highlighted selection.
; [ ] Draw spell submenu with learned-spell filtering.
; [ ] Draw item submenu with inventory quantities.
; [ ] Draw status screen (HP/MP/LV/STR/AGI/XP/GOLD/EQUIP).
; [ ] Add Yes/No prompt and generic selection dialog API.

; New files to create:
; [ ] ui_text.asm           ; text drawing and message paging
; [ ] ui_windows.asm        ; boxes, borders, and cursor sprite
; [ ] ui_status.asm         ; status panel layout and stat rendering
; [ ] font_8x8.asm          ; tile font lookup tables

; ============================================================
; PHASE 3 - BATTLE SYSTEM COMPLETION
; ============================================================
; [ ] Replace placeholder formulas with data-driven enemy stats.
; [ ] Add enemy templates (HP/STR/AGI/XP/GOLD/spell resist).
; [ ] Add hit/miss, crit, dodge, and damage variance rules.
; [ ] Add sleep status and turn skip handling.
; [ ] Add spell resistance checks (HURT/SLEEP).
; [ ] Add multi-line battle log text sequencing.
; [ ] Add encounter table by map/zone.
; [ ] Add proper run probability tied to AGI comparison.

; New files to create:
; [ ] battle_data.asm       ; enemy database and encounter groups
; [ ] battle_math.asm       ; combat formulas and RNG rolls
; [ ] battle_text.asm       ; battle message script templates

; ============================================================
; PHASE 4 - PLAYER PROGRESSION, ITEMS, SPELLS
; ============================================================
; [ ] Add level-up table (required XP, stat growth, spell learns).
; [ ] Add equipment data tables (weapon/armor/shield values).
; [ ] Add inventory capacity limits and item stack rules.
; [ ] Add field spell behaviors (HEAL/RADIANT/RETURN/REPEL style).
; [ ] Add death/gold loss/church respawn rules.
; [ ] Add shop buy/sell menu logic and pricing tables.
; [ ] Add inn healing and MP restore behavior.

; New files to create:
; [ ] progression.asm       ; XP thresholds and level gain logic
; [ ] items.asm             ; item metadata and use handlers
; [ ] spells.asm            ; spell metadata and cast handlers
; [ ] equipment.asm         ; equip stats and equip/unequip APIs

; ============================================================
; PHASE 5 - SAVE/LOAD AND WORLD FLOW
; ============================================================
; [ ] Define save-struct layout in WRAM/CMOS.
; [ ] Implement checksum/validation for save slots.
; [ ] Implement save and load menu flow from title/church.
; [ ] Add map spawn points and story progression flags.
; [ ] Add opening sequence and restart-from-save flow.

; New files to create:
; [ ] save.asm              ; serialization and checksum routines
; [ ] story_flags.asm       ; progression bits and event gating
; [ ] title_flow.asm        ; new game / continue menu behavior

; ============================================================
; PHASE 6 - AUDIO/VISUAL POLISH
; ============================================================
; [ ] Replace sound placeholders with real APU register writes.
; [ ] Add BGM state machine (title, field, battle, town, dungeon).
; [ ] Add SFX playback priority/channel reservation.
; [ ] Add palette setup and sprite/tile upload routines.
; [ ] Add NMI-driven PPU update queue for safe VRAM writes.
; [ ] Add simple animation steps (cursor blink, water tiles, enemy bob).

; New files to create:
; [ ] ppu_update_queue.asm  ; buffered PPU writes during NMI
; [ ] audio_apu.asm         ; APU driver and channel sequencing
; [ ] palettes.asm          ; palette data and swap routines

; ============================================================
; PHASE 7 - QA AND TOOLING
; ============================================================
; [ ] Add debug overlay (player coords, map id, RNG, battle state).
; [ ] Add assertions/sentinels for out-of-range menu indices.
; [ ] Add deterministic test seed mode for combat debugging.
; [ ] Add build script target for dragonwarrior ROM + symbol map.
; [ ] Add smoke test checklist (boot, menu, battle, save/load).

; New files to create:
; [ ] debug.asm             ; debug draw and toggle hotkeys
; [ ] test_hooks.asm        ; deterministic/testing helpers

; TODO List for Dragon Warrior NES Clone
.segment "TODO"

; List of remaining tasks and modules
.byte "Implement map rendering",0
.byte "Add battle logic",0
.byte "Expand menu system",0
.byte "Integrate editor features",0
.byte "Add sound/music routines",0
.byte "Test boot/splash screen",0
.byte "Optimize tile graphics",0
.byte "Add save/load system",0
.byte "Debug console build",0
.byte "Finalize ROM export",0

; Marker label so this file can be included safely later if desired.
.segment "CODE"
DW_TodoList_Marker:
    RTS
