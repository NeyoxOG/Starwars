# © Spark Universe, 2023
# authors: destruc7i0n
# description: called when a companion is tamed, by the player who tamed it
# called by: 

tag @s add tamer

tag @e[family=companion,c=1,r=10,tag=unclaimed] add just_tamed

scoreboard players operation @e[family=companion,c=1,tag=just_tamed] pet_id = @s player_id

execute as @e[family=companion,c=1,tag=just_tamed] run function spark/companion/sync_host/set_host
execute at @e[family=companion,c=1,tag=just_tamed] run particle spark:astromech_tame ~ ~ ~

tag @e[family=companion,tag=just_tamed] add tamed
tag @e[family=companion,tag=just_tamed,scores={pet_id=1..}] remove unclaimed

#tellraw @s {"rawtext": [{ "text": "§7§oTamed: " }, { "selector": "@e[family=companion,tag=just_tamed,tag=tamed]" }]}

tag @e[family=companion,tag=just_tamed,tag=tamed] remove just_tamed

