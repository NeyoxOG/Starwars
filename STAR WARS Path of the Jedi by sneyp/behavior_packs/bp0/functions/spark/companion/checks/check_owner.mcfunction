# © Spark Universe, 2023
# authors: destruc7i0n
# description: Handle pet saving and loading
# called by: companion/loop, run as the pet

scoreboard players operation .pet_check pet_id = @s pet_id
execute as @a if score @s player_id = .pet_check pet_id run tag @s add pet_owner
scoreboard players reset .pet_check pet_id

# reset if the owner appears
execute if entity @p[tag=pet_owner] if score @s pet_load matches 1.. run scoreboard players reset @s pet_load

execute unless entity @p[tag=pet_owner] run scoreboard players add @s pet_load 1
execute unless entity @p[tag=pet_owner] run tellraw @a[tag=debug] {"rawtext": [{ "text": "§7§oOwner not found for §r§e" }, { "selector": "@s" }, { "text": "§7§o, load: " }, { "score": { "name": "@s", "objective": "pet_load" } }]}

# save the pet if the owner has not existed for 3 seconds
execute if score @s pet_load matches 11 run tellraw @a[tag=debug] {"rawtext": [{ "text": "§7§oSaving pet for §r§e" }, { "selector": "@p[tag=pet_owner]" }, { "text": "§7§o..." }]}
execute unless entity @p[tag=pet_owner] if score @s pet_load matches 11 run function spark/companion/save/queue_save
execute if score @s pet_load matches 11 run scoreboard players reset @s pet_load

tag @a remove pet_owner
