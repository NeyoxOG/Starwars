#
execute if score .timer .monster_battle matches 24 run execute as @e[type=spark:box] at @s run function spark/force/entity/box/despawn
execute if score .timer .monster_battle matches 24 run execute positioned 5995.73 50.00 6015.00 run function spark/force/entity/box/create_size_3
execute if score .timer .monster_battle matches 24 run execute positioned 5997.01 50.00 5977.96 run function spark/force/entity/box/create_size_3
execute if score .timer .monster_battle matches 24 run execute positioned 6035.41 51.00 5987.17 run function spark/force/entity/box/create_size_3
execute if score .timer .monster_battle matches 24 run execute positioned 6027.46 50.00 6004.77 run function spark/force/entity/box/create_size_2
execute if score .timer .monster_battle matches 24 run execute positioned 6023.49 51.00 5968.28 run function spark/force/entity/box/create_size_2
execute if score .timer .monster_battle matches 24 run execute positioned 6019.03 50.00 6016.12 run function spark/force/entity/box/create_size_2
execute if score .timer .monster_battle matches 24 run execute positioned 5979.67 50.00 6000.02 run function spark/force/entity/box/create_size_2
execute if score .timer .monster_battle matches 24 run execute positioned 6025.53 51.00 5975.56 run function spark/force/entity/box/create_size_3
execute if score .timer .monster_battle matches 24 run execute positioned 6010.15 50.00 5985.79 run function spark/force/entity/box/create_size_2
execute if score .timer .monster_battle matches 24 run execute positioned 6005.57 50.00 6019.48 run function spark/force/entity/box/create_size_2
execute if score .timer .monster_battle matches 24 run event entity @e[type=spark:box] spark:texture_4
execute if score .timer .monster_battle matches 2 run scoreboard players set @a SS_ui_tutorial 0
execute if score .timer .monster_battle matches 2 run event entity @e[type=spark:sand_beast] spark:despawn


execute if score .timer .monster_battle matches 2 run function spark/cutscene/start_ch08_c03


execute if score .timer .monster_battle matches 250 run scoreboard players set .respawn .monster_battle 99
execute if score .timer .monster_battle matches 250 run function spark/monster_battle/phase/next
