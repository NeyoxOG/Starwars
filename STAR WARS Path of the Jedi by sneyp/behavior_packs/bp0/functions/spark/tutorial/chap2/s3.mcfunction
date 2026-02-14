# © Spark Universe, 2023
# authors: Arcaniax
# description: runs 20/s 
# called by: tutorial/loop

# ILLUM USE FORCE POWER

execute if score .timer tutorial matches 0 positioned 94.5 -26.00 3026.5 run dialogue change @e[c=1,r=1,type=spark:kelleran_beq] spark:illum.kelleran_2

execute if score .timer tutorial matches 0 run replaceitem entity @a slot.hotbar 0 spark:the_force 1 0 {"item_lock": { "mode": "lock_in_slot" }} 
execute if score .timer tutorial matches 0 run replaceitem entity @a slot.hotbar 1 spark:the_force 1 0 {"item_lock": { "mode": "lock_in_slot" }} 
execute if score .timer tutorial matches 0 run replaceitem entity @a slot.hotbar 2 spark:the_force 1 0 {"item_lock": { "mode": "lock_in_slot" }} 
execute if score .timer tutorial matches 0 run replaceitem entity @a slot.hotbar 3 spark:the_force 1 0 {"item_lock": { "mode": "lock_in_slot" }} 
execute if score .timer tutorial matches 0 run replaceitem entity @a slot.hotbar 4 spark:the_force 1 0 {"item_lock": { "mode": "lock_in_slot" }} 
execute if score .timer tutorial matches 0 run replaceitem entity @a slot.hotbar 5 spark:the_force 1 0 {"item_lock": { "mode": "lock_in_slot" }} 
execute if score .timer tutorial matches 0 run replaceitem entity @a slot.hotbar 6 spark:the_force 1 0 {"item_lock": { "mode": "lock_in_slot" }} 
execute if score .timer tutorial matches 0 run replaceitem entity @a slot.hotbar 7 spark:the_force 1 0 {"item_lock": { "mode": "lock_in_slot" }} 
execute if score .timer tutorial matches 0 run replaceitem entity @a slot.hotbar 8 spark:the_force 1 0 {"item_lock": { "mode": "lock_in_slot" }} 



execute if score .timer tutorial matches 10 run scoreboard players set @a SS_ui_tutorial 1

execute if score .timer tutorial matches 0 run scoreboard players set .force_hold tutorial 0
execute if score .timer tutorial matches 0 run tag @s remove force_hold

execute unless entity @a[tag=force_hold] if score .force_hold tutorial matches 3.. run event entity @e[family=padawan] spark:stop_force
execute unless entity @a[tag=force_hold] run scoreboard players set .force_hold tutorial 0
execute if entity @a[tag=force_hold] run scoreboard players add .force_hold tutorial 1

execute if score .force_hold tutorial matches 3 as @e[family=padawan] at @s run tp @s ~ ~0.01 ~ facing 87.01 -26 3025.0
execute if score .force_hold tutorial matches 3 run event entity @e[family=padawan,x=70,y=-24,z=3020,r=100] spark:start_force
execute if score .force_hold tutorial matches 5 run playsound sound.spark.crack_open_temple @a
execute if score .force_hold tutorial matches 5 run particle spark:ilum_entrance_crack 87.01 -26.00 3025.00
execute if score .force_hold tutorial matches 19 run particle spark:ilum_entrance_crack 88.01 -26.00 3030.05
execute if score .force_hold tutorial matches 30 run particle spark:ilum_entrance_crack 86.01 -26.00 3019.92
execute if score .force_hold tutorial matches 2..90 run camerashake add @a 0.06 0.05 rotational
execute if score .force_hold tutorial matches 2..90 run camerashake add @a 0.06 0.05 positional

execute if score .timer tutorial matches 90.. if score .force_hold tutorial matches 60.. run event entity @e[family=padawan] spark:stop_force
execute if score .timer tutorial matches 90.. if score .force_hold tutorial matches 60.. run function spark/tutorial/next

#execute if score .timer tutorial matches 50 run function spark/tutorial/next
