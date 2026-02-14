# © Spark Universe, 2023
# authors: ChainsawNinja
# description: main player loop
# called by: loop

# Sets up player ID
scoreboard players add @s ID 0
execute if score @s ID matches 0 run scoreboard players add .ID .data 1
execute if score @s ID matches 0 run scoreboard players operation @s ID = .ID .data

# Detects using an item
tag @s remove using_item
tag @s[tag=use_grab] add using_item
tag @s[tag=use_push] add using_item
tag @s[tag=use_pull] add using_item
tag @s[tag=use_insight] add using_item

execute as @s[tag=!using_item,scores={item.charge=1..}] at @s run function spark/force/player/item/use/end
scoreboard players set @s[tag=!using_item] item.charge 0
execute as @s[tag=using_item] at @s run function spark/force/player/item/use/loop