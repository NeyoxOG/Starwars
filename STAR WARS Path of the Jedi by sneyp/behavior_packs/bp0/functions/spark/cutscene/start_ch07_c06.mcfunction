### start cutscene ch07 c06 escape

scoreboard players set .ch07_c06 CS_trigger 1
scoreboard players set .timer CS_timer 0
camera @a[tag=!dev] set minecraft:first_person

execute if score .timer CS_timer matches 0 run tickingarea add circle 6069 -53 3113 1 tmp.cutscene.0

scoreboard players set .cs_loading CS_trigger 0
# title @a[tag=!dev] actionbar hud:fade_out_1
function spark/cutscene/load