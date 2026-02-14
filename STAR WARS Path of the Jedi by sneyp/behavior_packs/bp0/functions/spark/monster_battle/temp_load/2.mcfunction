#Despawn
execute as @e[type=spark:tusken_raider_melee] unless score @s .monster_battle = .id .monster_battle run event entity @s spark:despawn
execute as @e[type=spark:tusken_raider_ranged] unless score @s .monster_battle = .id .monster_battle run event entity @s spark:despawn
execute as @e[type=spark:box] unless score @s .monster_battle = .id .monster_battle at @s run function spark/force/entity/box/despawn
execute as @e[type=spark:box] unless score @s .monster_battle = .id .monster_battle at @s run kill @s

# cave section
execute positioned 6242.51 143.00 6042.70 run function spark/force/entity/box/create_size_3
execute positioned 6243.40 143.00 6058.57 run function spark/force/entity/box/create_size_3

# 1st push block, blocking enterance
execute positioned 6227.70 129.00 5986.30 run function spark/force/entity/box/create_size_3
execute positioned 6194.56 117.00 5935.49 run function spark/force/entity/box/create_size_3

summon spark:tusken_raider_melee 6219.5 134 6014.5 20 -25 spark:agro
summon spark:tusken_raider_ranged 6229.5 130 6001.5 30 -10

# after 1st push block, blocking enterance
summon spark:tusken_raider_ranged 6229.5 128 5974.5 0 0

summon spark:tusken_raider_melee 6220.5 125 5944.5 0 0 spark:agro
summon spark:tusken_raider_melee 6216.5 125 5942.5 0 0 spark:agro
summon spark:tusken_raider_melee 6218.5 125 5939.5 0 0 spark:agro

# before pit
summon spark:tusken_raider_ranged 6205 103 5953 150 -25
summon spark:tusken_raider_ranged 6201.5 101 5968.5 170 -10

scoreboard players set @a SS_ui_tutorial 0

scoreboard players set .respawn .monster_battle 3

#tp @p 6155.32 78.00 5938.06
#schedule delay add spark/monster_battle/temp_load/3 110

# block texture
event entity @e[type=spark:box] spark:texture_4

#IDS
scoreboard players operation @e[type=spark:box] .monster_battle = .id .monster_battle
scoreboard players operation @e[type=spark:tusken_raider_melee] .monster_battle = .id .monster_battle
scoreboard players operation @e[type=spark:tusken_raider_ranged] .monster_battle = .id .monster_battle