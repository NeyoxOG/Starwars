#Despawn
execute as @e[type=spark:felucia_raider_melee] unless score @s .monster_battle = .id .monster_battle run event entity @s spark:despawn
execute as @e[type=spark:felucia_raider_ranged] unless score @s .monster_battle = .id .monster_battle run event entity @s spark:despawn
execute as @e[type=spark:box] unless score @s .monster_battle = .id .monster_battle at @s run function spark/force/entity/box/despawn
execute as @e[type=spark:box] unless score @s .monster_battle = .id .monster_battle at @s run kill @s

summon spark:felucia_raider_melee 9021.5 53 6220.5 -80 0
summon spark:felucia_raider_melee 9020.5 53 6226.5 -95 0
summon spark:felucia_raider_ranged 9004.5 55 6222.5 -90 0

summon spark:felucia_raider_melee 8934.5 56 6139.5 0 0
summon spark:felucia_raider_ranged 8923.5 56 6134.5 -20 0

#IDS
scoreboard players operation @e[type=spark:box] .monster_battle = .id .monster_battle
scoreboard players operation @e[type=spark:felucia_raider_melee] .monster_battle = .id .monster_battle
scoreboard players operation @e[type=spark:felucia_raider_ranged] .monster_battle = .id .monster_battle