#
scoreboard players set @s item.type 2

#
function spark/force/player/force/reset_attacker

#
function spark/force/player/hitscan/execute

#
execute as @e[tag=hitscan_hit,tag=force_cube] at @s run function spark/force/entity/box/off_ground
execute as @e[tag=hitscan_hit,tag=force_cube] at @s run function spark/force/entity/box/unsolid

scoreboard players operation @e[tag=hitscan_hit] ID.attacker = @s ID
execute as @e[tag=hitscan_hit] at @s run tag @s add grabbed
scoreboard players set @e[tag=hitscan_hit] force_time 20

effect @e[tag=hitscan_hit] levitation 3 0 true

event entity @e[tag=hitscan_hit] spark:set_force_effect_pull