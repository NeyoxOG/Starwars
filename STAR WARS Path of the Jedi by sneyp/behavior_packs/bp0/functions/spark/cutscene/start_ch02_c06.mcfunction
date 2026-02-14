### start cutscene ch02 c06 crucible leaves ilum

scoreboard players set .ch02_c06 CS_trigger 1
scoreboard players set .timer CS_timer 0
camera @a[tag=!dev] set minecraft:first_person


tickingarea add circle  5997.5 65 -0.5 1 tmp.cutscene.0

playsound sound.spark.cutscene.crucible_takeoff @a

scoreboard players set .cs_loading CS_trigger 0
title @a[tag=!dev] actionbar hud:fade_out_1
function spark/cutscene/load