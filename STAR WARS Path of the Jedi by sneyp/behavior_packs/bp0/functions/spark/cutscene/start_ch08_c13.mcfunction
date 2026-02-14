### start cutscene ch09 c01 kamino arrive
scoreboard players set .ch08_c13 CS_trigger 1
scoreboard players set .timer CS_timer 0
camera @a[tag=!dev] set minecraft:first_person




tickingarea add circle 8828.5 55 6121.5 1 tmp.cutscene.0
tickingarea add circle 8823 55 6120 1 tmp.cutscene.1

scoreboard players set .cs_loading CS_trigger 0
title @a[tag=!dev] actionbar hud:fade_out_1
function spark/cutscene/load