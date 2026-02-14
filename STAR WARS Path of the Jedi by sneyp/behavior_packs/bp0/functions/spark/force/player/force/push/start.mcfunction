#
scoreboard players set @s item.type 3

tag @s remove weak_1
tag @s remove weak_2
tag @s remove weak_3

execute as @e[family=force,r=10] at @s run event entity @s spark:set_force_effect_push
