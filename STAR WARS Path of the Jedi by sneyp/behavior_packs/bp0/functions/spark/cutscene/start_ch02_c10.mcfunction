### start cutscene ch02 c10 astromech
scoreboard players set .ch02_c10 CS_trigger 1
scoreboard players set .timer CS_timer 0
camera @a[tag=!dev] set minecraft:first_person

tickingarea add circle 2970.5 -50.5 3085.6 1 tmp.cutscene.0
tickingarea add circle 3177.5 -39.5 3016.5 1 tmp.cutscene.1

scoreboard players set .cs_loading CS_trigger 0
title @a[tag=!dev] actionbar hud:fade_out_1
function spark/cutscene/load