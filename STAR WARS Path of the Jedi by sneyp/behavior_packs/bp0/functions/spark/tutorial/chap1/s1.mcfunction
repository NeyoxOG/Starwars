# © Spark Universe, 2023
# authors: Arcaniax
# description: runs 20/s 
# called by: chap1/loop

# INTRO [36 seconds]
replaceitem entity @a slot.armor.chest 0 spark:cloak_default 1 0 {"item_lock": { "mode": "lock_in_slot" }}
execute if score .timer tutorial matches 145 run function spark/tutorial/next_chapter