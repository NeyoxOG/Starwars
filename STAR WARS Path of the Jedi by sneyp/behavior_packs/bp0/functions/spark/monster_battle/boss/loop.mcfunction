#
execute unless entity @s[scores={t1=0..}] run scoreboard players add @s[tag=!start_attack,family=!sleep] t1 1
execute if entity @s[scores={t1=0..}] at @s if entity @p[r=12] run scoreboard players add @s[tag=!start_attack,family=!sleep] t1 1

execute as @s[scores={t1=100},type=spark:sand_beast] run tp @s ~ ~.1 ~ facing @p
execute as @s[scores={t1=100},type=spark:acklay] run tp @s ~ ~.1 ~ facing @p
execute as @s[scores={t1=100}] run summon spark:player_push ~ ~ ~ 0 0 spark:boss_roar
execute as @s[scores={t1=100}] run event entity @s[family=!sleep] spark:roaring
scoreboard players set @s[scores={t1=100..}] t1 -30
execute as @s[scores={t1=-1}] run event entity @s[family=!sleep] spark:melee

#
execute as @s[tag=power,tag=finish_attack,family=!sleep] run kill @e[type=spark:launch_boss]
event entity @s[tag=power,tag=finish_attack,family=!sleep] spark:melee
tag @s[tag=power,tag=finish_attack,family=!sleep] remove power

#
scoreboard players set @s[tag=finish_attack] t4 0
scoreboard players add @s[tag=finish_attack] t2 1
scoreboard players random @s[scores={t2=1},tag=finish_attack] t3 2 4
execute if score @s t2 = @s t3 run event entity @s[tag=finish_attack,family=!sleep] spark:power
execute if score @s t2 = @s t3 run tag @s add power
execute if score @s t2 = @s t3 run scoreboard players set @s t2 0

#
execute unless entity @s[tag=start_attack,tag=power] run scoreboard players set @s t4 0
scoreboard players add @s[tag=start_attack,tag=power] t4 1
execute as @s[tag=start_attack,tag=power,scores={t4=16}] run summon spark:launch_boss ^ ^ ^2 0 0

#
tag @s[tag=finish_attack] remove start_attack
tag @s remove finish_attack

#
execute if score .monster_stun .monster_battle matches ..0 run effect @s resistance 10 1 true
execute if score .monster_stun .monster_battle matches 1.. run effect @s resistance 0
execute if score .monster_stun .monster_battle matches 1.. run scoreboard players remove .monster_stun .monster_battle 1