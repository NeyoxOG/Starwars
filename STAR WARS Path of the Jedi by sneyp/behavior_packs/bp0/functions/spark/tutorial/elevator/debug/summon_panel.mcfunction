# called by: spark/temple_crafting_room/setup_elevator_buttons

execute if entity @s[rym=-45,ry=45] rotated 0 0 align xyz positioned ~0.5 ~ ~0.5 run function spark/tutorial/elevator/debug/summon_buttons
execute if entity @s[rym=45,ry=135] rotated 90 0 align xyz positioned ~0.5 ~ ~0.5 run function spark/tutorial/elevator/debug/summon_buttons
execute if entity @s[rym=135,ry=-135] rotated 180 0 align xyz positioned ~0.5 ~ ~0.5 run function spark/tutorial/elevator/debug/summon_buttons
execute if entity @s[rym=-135,ry=-45] rotated -90 0 align xyz positioned ~0.5 ~ ~0.5 run function spark/tutorial/elevator/debug/summon_buttons