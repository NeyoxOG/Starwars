#Despawn
execute as @e[type=spark:felucia_raider_melee] unless score @s .monster_battle = .id .monster_battle run event entity @s spark:despawn
execute as @e[type=spark:felucia_raider_ranged] unless score @s .monster_battle = .id .monster_battle run event entity @s spark:despawn
execute as @e[type=spark:box] unless score @s .monster_battle = .id .monster_battle at @s run function spark/force/entity/box/despawn
execute as @e[type=spark:box] unless score @s .monster_battle = .id .monster_battle at @s run kill @s

execute positioned 9059.43 49.00 5798.48 run function spark/force/entity/box/create_size_3
execute positioned 9052.27 51.00 5741.76 run function spark/force/entity/box/create_size_3

summon spark:felucia_raider_melee 9122.5 53 5808.5 135 0
summon spark:felucia_raider_melee 9127.5 53 5802.5 160 0

summon spark:felucia_raider_ranged 9127.5 52 5850.5 -180 0

scoreboard players set .respawn .monster_battle 2

# block texture
event entity @e[type=spark:box] spark:texture_2

#IDS
scoreboard players operation @e[type=spark:box] .monster_battle = .id .monster_battle
scoreboard players operation @e[type=spark:felucia_raider_melee] .monster_battle = .id .monster_battle
scoreboard players operation @e[type=spark:felucia_raider_ranged] .monster_battle = .id .monster_battle