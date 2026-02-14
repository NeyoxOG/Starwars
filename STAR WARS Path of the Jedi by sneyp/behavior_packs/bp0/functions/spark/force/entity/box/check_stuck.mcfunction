#
tag @s remove stuck
tp @e[tag=stuck_check] @s
execute as @s at @s run tp @s ~ ~0.002 ~ true
execute if entity @e[tag=stuck_check,r=0.001] run tag @s add stuck