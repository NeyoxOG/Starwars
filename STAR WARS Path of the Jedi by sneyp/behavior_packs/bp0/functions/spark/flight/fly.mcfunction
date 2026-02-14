# © Spark Universe, 2023
# authors: Jannis
# description: Controls the ship while it's in the air
# called by: 
# executor: ship


# Detect Ground
execute as @s if block ~ ~2 ~ air [] run tag @s add near_ground
execute as @s[tag=near_ground] if block ~ ~-5 ~ air [] if block ~ ~-4 ~ air [] if block ~ ~-3 ~ air [] if block ~ ~-2 ~ air [] if block ~ ~-1 ~ air [] run tag @s remove near_ground

execute as @s[tag=!on_ground,tag=is_moving] run function spark/flight/movement_air
execute as @s[tag=!on_ground,tag=!is_moving] run function spark/flight/movement_hover