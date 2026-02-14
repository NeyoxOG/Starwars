#
execute if score .timer .monster_battle matches 24 run execute as @e[type=spark:box] at @s run function spark/force/entity/box/despawn
execute if score .timer .monster_battle matches 24 run execute positioned 8828.11 55.00 6134.55 run function spark/force/entity/box/create_size_3
execute if score .timer .monster_battle matches 24 run execute positioned 8819.92 55.00 6108.10 run function spark/force/entity/box/create_size_3
execute if score .timer .monster_battle matches 24 run execute positioned 8843.94 55.00 6115.40 run function spark/force/entity/box/create_size_3
execute if score .timer .monster_battle matches 24 run execute positioned 8840.53 55.00 6104.06 run function spark/force/entity/box/create_size_2
execute if score .timer .monster_battle matches 24 run execute positioned 8845.74 56.00 6099.54 run function spark/force/entity/box/create_size_2
execute if score .timer .monster_battle matches 24 run execute positioned 8841.51 55.00 6135.16 run function spark/force/entity/box/create_size_2
execute if score .timer .monster_battle matches 24 run execute positioned 8804.60 55.00 6121.29 run function spark/force/entity/box/create_size_2
execute if score .timer .monster_battle matches 24 run event entity @e[type=spark:box] spark:texture_2
execute if score .timer .monster_battle matches 2 run scoreboard players set @a SS_ui_tutorial 0
execute if score .timer .monster_battle matches 2 run event entity @e[type=spark:acklay] spark:despawn


execute if score .timer .monster_battle matches 2 run function spark/cutscene/start_ch08_c13


execute if score .timer .monster_battle matches 150 run scoreboard players set .respawn .monster_battle 99
execute if score .timer .monster_battle matches 150 run function spark/monster_battle/phase/next
