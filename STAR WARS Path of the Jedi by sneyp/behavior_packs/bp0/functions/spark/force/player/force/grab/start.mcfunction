# © Spark Universe, 2023
# authors: ChainsawNinja
# description: start grab force event
# called by: 

# ID for item use
scoreboard players set @s item.type 1

# clear any remaining target
# safty steps
function spark/force/player/force/reset_attacker

# run hitscan to get target
function spark/force/player/hitscan/execute

#
tag @e[tag=hitscan_hit,scores={force_time=1..}] remove hitscan_hit
tag @e[tag=hitscan_hit,scores={ID.attacker=1..}] remove hitscan_hit

# start if target
scoreboard players operation @e[tag=hitscan_hit] ID.attacker = @s ID
scoreboard players set @e[tag=hitscan_hit] force_time 200

execute as @e[type=spark:marksman_droid,tag=hitscan_hit,tag=!force_proof] run scoreboard players add .force_kills tut_i_counter 1
execute as @e[type=spark:marksman_droid,tag=hitscan_hit,tag=!force_proof] run kill @s

# FOV toggle
#execute if entity @e[tag=hitscan_hit] run event entity @s spark:force_speed

execute if entity @e[tag=hitscan_hit] run tag @s add grab_success
execute if entity @e[tag=hitscan_hit] run tag @s add grab_user
# execute as @e[tag=hitscan_hit,type=spark:box] at @s run tag @s add grabbed
# execute as @e[tag=hitscan_hit,type=spark:box] at @s run function spark/force/entity/box/off_ground

execute as @e[tag=hitscan_hit,family=force] at @s run tag @s add grab_current
execute as @e[tag=hitscan_hit,tag=force_cube] at @s run tag @s add grabbed
execute as @e[tag=hitscan_hit,tag=force_cube] at @s run function spark/force/entity/box/off_ground

effect @e[tag=hitscan_hit] levitation 3 0 true
event entity @e[tag=hitscan_hit] spark:set_force_effect_grab