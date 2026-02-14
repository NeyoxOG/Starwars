### start cutscene ch02 c07 huyang reveal
scoreboard players set .ch02_c07 CS_trigger 1
scoreboard players set .timer CS_timer 0

camera @a[tag=!dev] set minecraft:first_person


tickingarea add circle 3018.5 -56 3035.5 1 tmp.cutscene.0

scoreboard players set .cs_loading CS_trigger 0
title @a[tag=!dev] actionbar hud:fade_out_1
function spark/cutscene/load