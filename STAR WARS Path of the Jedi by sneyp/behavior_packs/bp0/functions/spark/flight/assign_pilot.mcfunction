# © Spark Universe, 2023
# authors: Jannis
# description: Assigns the player in the seat to be pilot of the ship
# called by: 
# executor: ship

tag @s add piloted_ship
tag @s add self
tp @s ~ ~ ~ ~ 0


scoreboard players add @s plane_id 0
execute as @s[scores={plane_id=0}] run scoreboard players add main plane_id 1
scoreboard players operation @s[scores={plane_id=0}] plane_id = main plane_id

# Seat position list
execute positioned ^ ^1.5 ^-0.5 run tag @p[r=8] add target_pilot

scoreboard players operation @p[r=12,tag=target_pilot] plane_id = @s plane_id

tag @a[tag=target_pilot] remove target_pilot
tag @e[tag=self] remove self
