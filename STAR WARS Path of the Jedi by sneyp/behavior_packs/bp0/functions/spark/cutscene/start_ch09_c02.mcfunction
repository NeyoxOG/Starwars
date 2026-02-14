### start cutscene ch09 c02 kamino defeat
scoreboard players set .ch09_c02 CS_trigger 1
scoreboard players set .timer CS_timer 0
camera @a[tag=!dev] set minecraft:first_person

scoreboard players set .cs_loading CS_trigger 0
tickingarea add circle 9026.5 95 0.5 1 tmp.cutscene.0
tickingarea add circle 9026.5 95 0.5 1 tmp.cutscene.1
function spark/cutscene/load