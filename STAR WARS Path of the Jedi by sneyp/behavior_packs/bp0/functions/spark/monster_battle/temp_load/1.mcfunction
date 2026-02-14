#Despawn
execute as @e[type=spark:tusken_raider_melee] unless score @s .monster_battle = .id .monster_battle run event entity @s spark:despawn
execute as @e[type=spark:tusken_raider_ranged] unless score @s .monster_battle = .id .monster_battle run event entity @s spark:despawn
execute as @e[type=spark:box] unless score @s .monster_battle = .id .monster_battle at @s run function spark/force/entity/box/despawn
execute as @e[type=spark:box] unless score @s .monster_battle = .id .monster_battle at @s run kill @s

# first section before cave
execute positioned 6304.26 151.00 6016.48 run function spark/force/entity/box/create_size_3
execute positioned 6293.58 154.00 6049.37 run function spark/force/entity/box/create_size_3

summon spark:tusken_raider_melee 6253.5 146 6055.5 -100 0 spark:agro
summon spark:tusken_raider_ranged 6254.5 145 6051.5 -90 0

scoreboard players set .respawn .monster_battle 2

#tp @p 6242.95 144.00 6062.00
#schedule delay add spark/monster_battle/temp_load/2 70

# block texture
event entity @e[type=spark:box] spark:texture_4

#IDS
scoreboard players operation @e[type=spark:box] .monster_battle = .id .monster_battle
scoreboard players operation @e[type=spark:tusken_raider_melee] .monster_battle = .id .monster_battle
scoreboard players operation @e[type=spark:tusken_raider_ranged] .monster_battle = .id .monster_battle