### start cutscene ch09 c01 tatooine arrive
scoreboard players set .ch08_c01 CS_trigger 1
scoreboard players set .timer CS_timer 0
camera @a[tag=!dev] set minecraft:first_person


tickingarea add circle 6354.5 159 5952.5 2 tmp.cutscene.0
tickingarea add circle 5997.5 65 -0.5 1 tmp.cutscene.1
tickingarea add circle 6334.5 159 5952.5 1 tmp.cutscene.2

scoreboard players set .cs_loading CS_trigger 0
title @a[tag=!dev] actionbar hud:fade_out_1
function spark/cutscene/load