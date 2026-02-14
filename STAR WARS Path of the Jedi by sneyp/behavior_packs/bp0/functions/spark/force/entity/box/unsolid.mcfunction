#
#tag @e[type=spark:box] add old_spawn
#execute as @s[tag=size_2] at @s run summon spark:box ~ ~ ~ ~ ~ spark:size_2
#execute as @s[tag=size_2] at @s run tag @e[type=spark:box,tag=!old_spawn] add size_2

#execute as @s[tag=size_3] at @s positioned ~ ~ ~ run summon spark:box ~ ~ ~ ~ ~ spark:size_3
#execute as @s[tag=size_3] at @s run tag @e[type=spark:box,tag=!old_spawn] add size_3

#execute as @s[tag=size_5] at @s positioned ~ ~ ~ run summon spark:box ~ ~ ~ ~ ~ spark:size_5
#execute as @s[tag=size_5] at @s run tag @e[type=spark:box,tag=!old_spawn] add size_5

#scoreboard players operation @e[type=spark:box,tag=!old_spawn] ID.attacker = @s ID.attacker
#execute as @s[tag=hitscan_hit] run tag @e[type=spark:box,tag=!old_spawn] add hitscan_hit

#tag @s add kill
#event entity @s spark:despawn

execute as @s[tag=size_1] at @s run event entity @s spark:size_1
execute as @s[tag=size_2] at @s run event entity @s spark:size_2
execute as @s[tag=size_3] at @s run event entity @s spark:size_3
execute as @s[tag=size_5] at @s run event entity @s spark:size_5

tag @s remove solid
tag @s remove unsolid

tag @s remove off_ground
tag @s remove off_ground_t

tag @s add bump

event entity @s spark:set_force_effect_none

#
effect @s slow_falling 1 1 true
scoreboard players set @s fall_time 0
scoreboard players set @s t2 0