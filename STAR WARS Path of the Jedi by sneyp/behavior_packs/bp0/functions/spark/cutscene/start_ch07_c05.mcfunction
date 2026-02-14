### start cutscene ch07 c05 grievous

scoreboard players set .ch07_c05 CS_trigger 1
scoreboard players set .timer CS_timer 0
scoreboard players set .timer_shot CS_timer 0
camera @a[tag=!dev] set minecraft:first_person

tickingarea add circle 6036.5 -53 3115.5 1 tmp.cutscene.0

scoreboard players set .cs_loading CS_trigger 0
title @a[tag=!dev] actionbar hud:fade_out_1
function spark/cutscene/load

