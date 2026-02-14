### start cutscene ch07 c02 gunships
scoreboard players set .ch07_c02 CS_trigger 1
scoreboard players set .timer CS_timer 0
camera @a[tag=!dev] set minecraft:first_person


tickingarea add circle 5975.5 -49.5 2601.5 1 tmp.cutscene.0
tickingarea add circle 5910.5 -55.00 2601.5 1 tmp.cutscene.1
tickingarea add circle 216 99.59 6 1 tmp.cutscene.2
tickingarea add circle 5997.5 65 -0.5 2 tmp.cutscene.3
tickingarea add circle 191.55 98.00 28.53 1 tmp.cutscene.4


scoreboard players set .cs_loading CS_trigger 0
# title @a[tag=!dev] actionbar hud:fade_out_1
function spark/cutscene/load