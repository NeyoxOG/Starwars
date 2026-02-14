#Despawn
execute as @e[type=spark:felucia_raider_melee] unless score @s .monster_battle = .id .monster_battle run event entity @s spark:despawn
execute as @e[type=spark:felucia_raider_ranged] unless score @s .monster_battle = .id .monster_battle run event entity @s spark:despawn
execute as @e[type=spark:box] unless score @s .monster_battle = .id .monster_battle at @s run function spark/force/entity/box/despawn
execute as @e[type=spark:box] unless score @s .monster_battle = .id .monster_battle at @s run kill @s

execute positioned 9096.46 48.00 6259.49 run function spark/force/entity/box/create_size_5

summon spark:felucia_raider_melee 9105.76 51.00 6218.19 -72.58 7.37
summon spark:felucia_raider_melee 9108.5 51 6225.5 -100 0
summon spark:felucia_raider_ranged 9091.5 51 6223.5 -95 0

summon spark:felucia_raider_ranged 9129.5 48 6256.5 -90 0
summon spark:felucia_raider_ranged 9121.5 48 6262.5 -90 0

# block texture
event entity @e[type=spark:box] spark:texture_2

#IDS
scoreboard players operation @e[type=spark:box] .monster_battle = .id .monster_battle
scoreboard players operation @e[type=spark:felucia_raider_melee] .monster_battle = .id .monster_battle
scoreboard players operation @e[type=spark:felucia_raider_ranged] .monster_battle = .id .monster_battle