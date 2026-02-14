### start cutscene ch10 c01 torren arrive
scoreboard players set .ch10_c01 CS_trigger 1
scoreboard players set .timer CS_timer 0
scoreboard players set .cs_loading CS_trigger 0
scoreboard players set .timer_shot CS_timer 0

# setup loading into cutscene
title @a[tag=!dev] actionbar hud:fade_out_1
tickingarea add circle 5997.5 62 8999.5 1 tmp.cutscene.0
tickingarea add circle 5997.5 65 -0.5 1 tmp.cutscene.1
function spark/cutscene/load
music stop 5.0