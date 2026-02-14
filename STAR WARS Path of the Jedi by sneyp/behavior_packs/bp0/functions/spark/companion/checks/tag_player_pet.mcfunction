# © Spark Universe, 2023
# authors: destruc7i0n
# description: tag the pet that is owned by the player, run as the player
# called by: 

scoreboard players operation .pet_check player_id = @s player_id
execute as @e[family=companion,tag=tamed] if score @s pet_id = .pet_check player_id run tag @s add player_pet
scoreboard players reset .pet_check player_id
