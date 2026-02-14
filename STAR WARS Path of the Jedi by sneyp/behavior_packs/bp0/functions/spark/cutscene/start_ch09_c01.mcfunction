### start cutscene ch09 c01 kamino arrive
scoreboard players set .ch09_c01 CS_trigger 1
scoreboard players set .timer CS_timer 0
camera @a[tag=!dev] set minecraft:first_person

tickingarea add circle 9136.5 101 -64.5 1 tmp.cutscene.0
tickingarea add circle 5997.5 65 -0.5  1 tmp.cutscene.1


scoreboard players set .cs_loading CS_trigger 0
title @a[tag=!dev] actionbar hud:fade_out_1
function spark/cutscene/load