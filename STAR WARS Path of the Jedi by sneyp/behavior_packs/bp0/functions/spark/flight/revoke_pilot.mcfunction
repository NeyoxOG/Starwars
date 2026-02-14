# © Spark Universe, 2023
# authors: Jannis
# description: Disconnects ship and pilot
# called by: 
# executor: ship

scoreboard players operation @a[scores={plane_id=1..}] temp_id = @s plane_id
execute as @a[scores={plane_id=1..}] run scoreboard players operation @s temp_id -= @s plane_id
effect @a[scores={plane_id=1..,temp_id=0}] invisibility 0
scoreboard players set @a[scores={plane_id=1..,temp_id=0}] plane_id 0
tag @s remove piloted_ship
effect @s levitation 0
effect @s slow_falling 0
