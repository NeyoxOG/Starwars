### start cutscene ch 02 c 04 melting gate

playsound sound.spark.cutscene.gathering_crystal @a

scoreboard players set .ch02_c04 CS_trigger 1
scoreboard players set .timer CS_timer 0
camera @a[tag=!dev] set minecraft:first_person


tickingarea add -7.5 38 3014.5 14.5 82 3028.5 tmp.cutscene.0
tickingarea add circle 39.5 61 3021.5 1 tmp.cutscene.1


scoreboard players set .cs_loading CS_trigger 0
title @a[tag=!dev] actionbar hud:fade_out_1
function spark/cutscene/load