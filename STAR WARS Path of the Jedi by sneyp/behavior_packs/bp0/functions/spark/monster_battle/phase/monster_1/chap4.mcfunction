#
execute if score .timer .monster_battle matches 10 run scoreboard players set @a SS_ui_tutorial 30

#
execute positioned 6294.36 155.41 6006.59 if score .trigger_1 .monster_battle matches 0 if entity @p[r=16] run function spark/monster_battle/temp_load/1
execute positioned 6294.36 155.41 6006.59 if score .trigger_1 .monster_battle matches 0 if entity @p[r=16] run scoreboard players set .trigger_1 .monster_battle 1

execute positioned 6280 150 6043 if score .trigger_2 .monster_battle matches 0 if entity @p[r=10] run function spark/monster_battle/temp_load/2
execute positioned 6280 150 6043 if score .trigger_2 .monster_battle matches 0 if entity @p[r=10] run scoreboard players set .trigger_2 .monster_battle 1

execute positioned 6205 96 5945 if score .trigger_3 .monster_battle matches 0 if entity @p[r=30] run function spark/monster_battle/temp_load/3
execute positioned 6205 96 5945 if score .trigger_3 .monster_battle matches 0 if entity @p[r=30] run scoreboard players set .trigger_3 .monster_battle 1

# execute positioned 6057 67 5987 if score .trigger_4 .monster_battle matches 0 if entity @p[r=60] run function spark/monster_battle/temp_load/boss_1
execute positioned 6057 67 5987 if score .trigger_4 .monster_battle matches 0 if entity @p[r=60] run scoreboard players set .trigger_4 .monster_battle 1

execute positioned 6007 50 5988 if entity @p[r=66] run function spark/monster_battle/phase/next