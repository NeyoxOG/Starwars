# © Spark Universe, 2023
# authors: Arcaniax
# description: runs 20/s 
# called by: tutorial/loop

# YODA GIVING FORCE POWERS

#execute if score .timer tutorial matches 0 run replaceitem entity @a slot.hotbar 1 spark:insight 1 0 {"item_lock": { "mode": "lock_in_slot" }}
execute if score .timer tutorial matches 0 run replaceitem entity @a slot.hotbar 1 spark:push 1 0 {"item_lock": { "mode": "lock_in_slot" }}
execute if score .timer tutorial matches 0 run replaceitem entity @a slot.hotbar 2 spark:grab 1 0 {"item_lock": { "mode": "lock_in_slot" }}
execute if score .timer tutorial matches 0 run replaceitem entity @a slot.hotbar 3 spark:pull 1 0 {"item_lock": { "mode": "lock_in_slot" }}

# execute if score .timer tutorial matches 0 run tag @a remove hide_hotbar

execute as @e[type=spark:yoda] at @s run particle spark:npc_exclamation ~ ~1.75 ~
execute if score .timer tutorial matches 0 positioned 0.5 -25.00 3021.5 run dialogue change @e[c=1,r=1,type=spark:yoda] spark:illum.yoda_2

execute if score .timer tutorial matches 1 positioned 0.5 -25.00 3021.5 run dialogue open @e[c=1,r=1,type=spark:yoda] @a

execute if score .timer tutorial matches 2.. if score .npc_trigger tutorial matches 1.. run function spark/tutorial/next