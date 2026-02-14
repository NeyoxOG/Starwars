### start cutscene ch02 c12 knighting
scoreboard players set .ch02_c12 CS_trigger 1
scoreboard players set .timer CS_timer 0


tickingarea add circle 9200.5 37 8984.5 1 tmp.cutscene.0


scoreboard players set .cs_loading CS_trigger 0
title @a[tag=!dev] actionbar hud:fade_out_1
function spark/cutscene/load