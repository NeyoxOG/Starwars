# © Spark Universe, 2023
# authors: destruc7i0n
# description: Check the player's pet, loading them if they do not exist, moving them closer if too far
# called by: companion/loop, by any player who has a pet

function spark/companion/checks/tag_player_pet

# remove invisibility and add back mobile
effect @e[family=companion,tag=player_pet] invisibility 0 0 true
event entity @e[family=companion,tag=player_pet,tag=!no_tp] spark:mobile

# tp if more than 50 blocks away
execute unless entity @e[family=companion,tag=player_pet,c=1,r=50] run tp @e[family=companion,tag=player_pet,c=1,tag=!no_tp] @s

# count how many seconds the pet has not existed for
execute unless entity @e[family=companion,tag=player_pet,c=1] run scoreboard players add @s pet_load 1
execute unless entity @e[family=companion,tag=player_pet,c=1] run tellraw @s[tag=debug] {"rawtext": [{ "text": "§7§oCompanion not found..." }]}

# try to load the pet if it has not existed for 3 seconds, try to load it 4 times
execute unless entity @e[family=companion,tag=player_pet,c=1] if score @s pet_load matches 3.. run function spark/companion/save/do_load
execute if score @s pet_load matches 3 run tellraw @s[tag=debug] {"rawtext": [{ "text": "§7§oAttempting to load pet..." }]}
execute if score @s pet_load matches 6 run tellraw @s[tag=debug] {"rawtext": [{ "text": "§7§oCould not load your pet!" }]}
execute if score @s pet_load matches 6 run function spark/companion/save/delete_saved_pet
execute if score @s pet_load matches 6 run tag @s remove tamer
execute if score @s pet_load matches 6 run scoreboard players reset @s pet_load

function spark/companion/checks/tag_player_pet

# reset the counter if the pet was loaded or if it was too far away
execute if entity @e[family=companion,tag=player_pet,c=1] if score @s pet_load matches 1.. run tellraw @s[tag=debug] {"rawtext": [{ "text": "§7§oCompanion loaded!" }]}
execute if entity @e[family=companion,tag=player_pet,c=1] if score @s pet_load matches 1.. run function spark/companion/save/delete_saved_pet
execute if entity @e[family=companion,tag=player_pet,c=1] if score @s pet_load matches 1.. run scoreboard players reset @s pet_load

tag @e[family=companion,tag=player_pet] remove player_pet
