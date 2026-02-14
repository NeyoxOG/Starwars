#
scoreboard players set @s item.type 4

#
tag @e[type=spark:marker_force] add old
summon spark:marker_force ~ ~ ~

scoreboard players add @e[type=spark:marker_force,tag=!old] s1 0
scoreboard players add @e[type=spark:marker_force,tag=!old] s2 0
scoreboard players add @e[type=spark:marker_force,tag=!old] s3 0
scoreboard players add @e[type=spark:marker_force,tag=!old] s4 0
scoreboard players add @e[type=spark:marker_force,tag=!old] s5 0
scoreboard players add @e[type=spark:marker_force,tag=!old] s6 0

tp @e[type=spark:marker_force,tag=!old] @s

execute as @e[type=spark:marker_force,tag=!old] at @s run tp @s ~ ~ ~ ~ 0

scoreboard players operation @e[type=spark:marker_force,tag=!old] ID = @s ID

tag @e[type=spark:marker_force,tag=!old] add insight