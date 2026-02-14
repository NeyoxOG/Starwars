#
execute if score .timer .monster_battle matches 10 run scoreboard players set @a SS_ui_tutorial 30

#
execute positioned 9025 41 5768 if score .trigger_1 .monster_battle matches 0 if entity @p[r=50] run function spark/monster_battle/temp_load/1b
execute positioned 9025 41 5768 if score .trigger_1 .monster_battle matches 0 if entity @p[r=50] run scoreboard players set .trigger_1 .monster_battle 1

execute positioned 9173 50 6172 if score .trigger_2 .monster_battle matches 0 if entity @p[r=23] run function spark/monster_battle/temp_load/2b
execute positioned 9173 50 6172 if score .trigger_2 .monster_battle matches 0 if entity @p[r=23] run scoreboard players set .trigger_2 .monster_battle 1

execute positioned 9131 43 6234 if score .trigger_3 .monster_battle matches 0 if entity @p[r=40] run function spark/monster_battle/temp_load/3b
execute positioned 9131 43 6234 if score .trigger_3 .monster_battle matches 0 if entity @p[r=40] run scoreboard players set .trigger_3 .monster_battle 1

execute positioned 9121.40 58.00 5910.51 if score .trigger_4 .monster_battle matches 0 if entity @p[r=20] run function spark/monster_battle/temp_load/4b
execute positioned 9121.40 58.00 5910.51 if score .trigger_4 .monster_battle matches 0 if entity @p[r=20] run scoreboard players set .trigger_4 .monster_battle 1

execute positioned 9174.11 51.00 6098.73 if score .trigger_5 .monster_battle matches 0 if entity @p[r=20] run function spark/monster_battle/temp_load/5b
execute positioned 9174.11 51.00 6098.73 if score .trigger_5 .monster_battle matches 0 if entity @p[r=20] run scoreboard players set .trigger_5 .monster_battle 1

execute positioned 9174 56 6030.5 if score .trigger_7 .monster_battle matches 0 if entity @p[r=20] run function spark/monster_battle/temp_load/6b
execute positioned 9174 56 6030.5 if score .trigger_7 .monster_battle matches 0 if entity @p[r=20] run scoreboard players set .trigger_7 .monster_battle 1

execute positioned 9038.90 52.14 6227.44 if score .trigger_8 .monster_battle matches 0 if entity @p[r=30] run function spark/monster_battle/temp_load/7b
execute positioned 9038.90 52.14 6227.44 if score .trigger_8 .monster_battle matches 0 if entity @p[r=30] run scoreboard players set .trigger_8 .monster_battle 1

execute positioned 9127.5 52 5825.5 if score .trigger_9 .monster_battle matches 0 if entity @p[r=40] run function spark/monster_battle/temp_load/8b
execute positioned 9127.5 52 5825.5 if score .trigger_9 .monster_battle matches 0 if entity @p[r=40] run scoreboard players set .trigger_9 .monster_battle 1

# execute positioned 8863 55 6120 if score .trigger_6 .monster_battle matches 0 if entity @p[r=45] run function spark/monster_battle/temp_load/boss_2
execute positioned 8863 55 6120 if score .trigger_6 .monster_battle matches 0 if entity @p[r=45] run scoreboard players set .trigger_6 .monster_battle 1

execute positioned 8863 55 6120 if entity @p[r=26] run function spark/monster_battle/phase/next