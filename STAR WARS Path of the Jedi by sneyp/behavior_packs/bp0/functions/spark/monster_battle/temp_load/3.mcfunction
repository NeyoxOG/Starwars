#Despawn
execute as @e[type=spark:tusken_raider_melee] unless score @s .monster_battle = .id .monster_battle run event entity @s spark:despawn
execute as @e[type=spark:tusken_raider_ranged] unless score @s .monster_battle = .id .monster_battle run event entity @s spark:despawn
execute as @e[type=spark:box] unless score @s .monster_battle = .id .monster_battle at @s run function spark/force/entity/box/despawn
execute as @e[type=spark:box] unless score @s .monster_battle = .id .monster_battle at @s run kill @s

# pit puzzle section
execute positioned 6165.63 75.00 5981.32 run function spark/force/entity/box/create_size_3
execute positioned 6189.54 77.00 5956.60 run function spark/force/entity/box/create_size_3
execute positioned 6180.52 75.00 5968.57 run function spark/force/entity/box/create_size_3

summon spark:tusken_raider_melee 6177 74 5961 -50 -50 spark:agro
summon spark:tusken_raider_ranged 6170.5 72 5971 -50 -50
summon spark:tusken_raider_melee 6183 75 5976.5 180 -40 spark:agro

# final section
execute positioned 6160.55 89.00 5922.29 run function spark/force/entity/box/create_size_3
execute positioned 6139.37 83.00 5907.59 run function spark/force/entity/box/create_size_3
execute positioned 6144.47 83.00 5902.38 run function spark/force/entity/box/create_size_3

summon spark:tusken_raider_melee 6120 93 5908 -180 0 spark:agro
summon spark:tusken_raider_melee 6115.6 92 5900 -140 0 spark:agro
summon spark:tusken_raider_ranged 6119 92 5902 150 0

# boss transition section
summon spark:tusken_raider_melee 6107 76 5995 -83 0 spark:agro
summon spark:tusken_raider_melee 6108 76 5990 -63 0 spark:agro
summon spark:tusken_raider_ranged 6096 74 5989 -70 0

scoreboard players set .respawn .monster_battle 4

#schedule delay add spark/monster_battle/temp_load/4 40

# block texture
event entity @e[type=spark:box] spark:texture_4

#IDS
scoreboard players operation @e[type=spark:box] .monster_battle = .id .monster_battle
scoreboard players operation @e[type=spark:tusken_raider_melee] .monster_battle = .id .monster_battle
scoreboard players operation @e[type=spark:tusken_raider_ranged] .monster_battle = .id .monster_battle