#Despawn
execute as @e[type=spark:felucia_raider_melee] unless score @s .monster_battle = .id .monster_battle run event entity @s spark:despawn
execute as @e[type=spark:felucia_raider_ranged] unless score @s .monster_battle = .id .monster_battle run event entity @s spark:despawn
execute as @e[type=spark:box] unless score @s .monster_battle = .id .monster_battle at @s run function spark/force/entity/box/despawn
execute as @e[type=spark:box] unless score @s .monster_battle = .id .monster_battle at @s run kill @s

#
summon spark:felucia_raider_melee 9120.5 58 5924.5 180 0
summon spark:felucia_raider_melee 9129.5 58 5922.5 170 0
summon spark:felucia_raider_ranged 9125.5 58 5933 180 0

summon spark:felucia_raider_melee 9089.5 56 6016.5 -180 0
summon spark:felucia_raider_melee 9083.5 56 6010.5 -145 0
summon spark:felucia_raider_melee 9085.5 56 6020.5 -180 0

scoreboard players set @a SS_ui_tutorial 0

scoreboard players set .respawn .monster_battle 4

#IDS
scoreboard players operation @e[type=spark:box] .monster_battle = .id .monster_battle
scoreboard players operation @e[type=spark:felucia_raider_melee] .monster_battle = .id .monster_battle
scoreboard players operation @e[type=spark:felucia_raider_ranged] .monster_battle = .id .monster_battle