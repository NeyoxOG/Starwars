scoreboard players random .random droid_survival 1 4
execute if score .random droid_survival matches 1..3 run summon spark:b1_battle_droid ~ ~ ~ facing @p[m=!spectator] spark:raider
execute if score .random droid_survival matches 4 run summon spark:b2_battle_droid ~ ~ ~ facing @p[m=!spectator] spark:raider

scoreboard players random .random droid_survival 1 4
execute if score .random droid_survival matches 1..3 run summon spark:b1_battle_droid ~ ~ ~ facing @p[m=!spectator] spark:raider
execute if score .random droid_survival matches 4 run summon spark:b2_battle_droid ~ ~ ~ facing @p[m=!spectator] spark:raider

scoreboard players set @s timer 0
spreadplayers ~ ~ 1 2 @e[family=raider,tag=!spread,r=2]
execute as @e[family=raider,tag=!spread,r=5] at @s if block ~ ~-0.5 ~ spark:dead_droid_pile_1 run tp @s ~ ~-0.5 ~
execute as @e[family=raider,tag=!spread,r=5] at @s if block ~ ~-0.25 ~ spark:dead_droid_pile_1 run tp @s ~ ~-0.25 ~
execute as @e[family=raider,tag=!spread,r=5] at @s if block ~ ~-0.5 ~ spark:dead_droid_pile_2 run tp @s ~ ~-0.5 ~
execute as @e[family=raider,tag=!spread,r=5] at @s if block ~ ~-0.25 ~ spark:dead_droid_pile_2 run tp @s ~ ~-0.25 ~
execute as @e[family=raider,tag=!spread,r=5] at @s if block ~ ~-0.5 ~ spark:dead_droid_pile_3 run tp @s ~ ~-0.5 ~
execute as @e[family=raider,tag=!spread,r=5] at @s if block ~ ~-0.25 ~ spark:dead_droid_pile_3 run tp @s ~ ~-0.25 ~
execute as @e[family=raider,tag=!spread,r=5] at @s if block ~ ~-0.5 ~ spark:dead_droid_pile_4 run tp @s ~ ~-0.5 ~
execute as @e[family=raider,tag=!spread,r=5] at @s if block ~ ~-0.25 ~ spark:dead_droid_pile_4 run tp @s ~ ~-0.25 ~
tag @e[family=raider,tag=!spread,r=5] add spread