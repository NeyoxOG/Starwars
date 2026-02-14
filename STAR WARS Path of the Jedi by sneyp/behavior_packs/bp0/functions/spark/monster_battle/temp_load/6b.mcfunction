#Despawn
execute as @e[type=spark:felucia_raider_melee] unless score @s .monster_battle = .id .monster_battle run event entity @s spark:despawn
execute as @e[type=spark:felucia_raider_ranged] unless score @s .monster_battle = .id .monster_battle run event entity @s spark:despawn
execute as @e[type=spark:box] unless score @s .monster_battle = .id .monster_battle at @s run function spark/force/entity/box/despawn
execute as @e[type=spark:box] unless score @s .monster_battle = .id .monster_battle at @s run kill @s

#
summon spark:felucia_raider_ranged 9174 56 6030.5 90 0
summon spark:felucia_raider_ranged 9174.5 56 6023.5 80 0

summon spark:felucia_raider_ranged 9170.5 51 6082.5 -180 0
summon spark:felucia_raider_ranged 9175.5 51 6082.5 -180 0

#IDS
scoreboard players operation @e[type=spark:box] .monster_battle = .id .monster_battle
scoreboard players operation @e[type=spark:felucia_raider_melee] .monster_battle = .id .monster_battle
scoreboard players operation @e[type=spark:felucia_raider_ranged] .monster_battle = .id .monster_battle