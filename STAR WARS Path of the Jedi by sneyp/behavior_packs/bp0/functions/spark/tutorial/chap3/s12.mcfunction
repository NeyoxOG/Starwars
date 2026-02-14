# © Spark Universe, 2023
# authors: William Savage
# description: runs 20/s 
# called by: chap3/loop

#
execute if score .timer tutorial matches 1.. positioned 2970 -57 3057 unless entity @a[x=3036,y=-57,z=3044,dx=-75,dy=20,dz=13] run event entity @e[type=spark:crucible_gate_large,c=1] spark:close_door
execute if score .timer tutorial matches 50 run event entity @e[type=spark:ship_emergency_light,x=3000,y=-56,z=3050,r=50] spark:disable

# while within [x=2978,y=-57,z=3057,dx=-16,dy=6,dz=28,c=1], if the player has the force items, then tag the entity to it doesnt happen again
execute as @a[x=2978,y=-57,z=3057,dx=-16,dy=6,dz=28,tag=!replaced] run replaceitem entity @s slot.hotbar 0 spark:power_cell 1 0 {"item_lock": { "mode": "lock_in_slot" }}
execute as @a[x=2978,y=-57,z=3057,dx=-16,dy=6,dz=28,tag=!replaced] run replaceitem entity @s slot.hotbar 1 spark:paint_tool 1 0 {"item_lock": { "mode": "lock_in_slot" }}
execute as @a[x=2978,y=-57,z=3057,dx=-16,dy=6,dz=28,tag=!replaced] run replaceitem entity @s slot.hotbar 2 spark:head_tool 1 0 {"item_lock": { "mode": "lock_in_slot" }}
execute as @a[x=2978,y=-57,z=3057,dx=-16,dy=6,dz=28,tag=!replaced] run replaceitem entity @s slot.hotbar 3 spark:pattern_tool 1 0 {"item_lock": { "mode": "lock_in_slot" }}
execute as @a[x=2978,y=-57,z=3057,dx=-16,dy=6,dz=28,tag=!replaced] run playsound sound.spark.droid_pickup_cell @p
execute as @a[x=2978,y=-57,z=3057,dx=-16,dy=6,dz=28,tag=!replaced] run music stop 0.5
execute as @a[x=2978,y=-57,z=3057,dx=-16,dy=6,dz=28,tag=!replaced] run music play sound.spark.music.JarJarsIntroduction 1.0 0.1 loop
execute as @a[x=2978,y=-57,z=3057,dx=-16,dy=6,dz=28,tag=!replaced] run tag @s add replaced

# reset tutorial message to the new one, item picks up and stuff
execute if score .timer tutorial matches 35 run scoreboard players set @a SS_ui_tutorial 15
execute if score .timer tutorial matches 35 run playsound sound.spark.quest_minor @a

execute if score .timer tutorial matches 1 run scoreboard players set .derust tutorial 0
execute if score .timer tutorial matches 1 run scoreboard players set .all_done tutorial 0
#playanimation @e[type=spark:astromech,tag=derusted,tag=!first_active] animation.spark.astromech.attack
execute if score .timer tutorial matches 36.. if score .derust tutorial matches 100.. positioned 2970 -57 3057 if entity @e[type=spark:astromech,tag=derusted,r=30] run scoreboard players set @a SS_ui_tutorial 16
execute if score .timer tutorial matches 36.. if score .derust tutorial matches ..100 positioned 2970 -57 3057 if entity @e[type=spark:astromech,tag=derusted,r=30] run scoreboard players add .derust tutorial 1

tag @e[type=spark:astromech,tag=derusted] add first_active

# hallway effects
function spark/particles/crucible_crash

# clear tutorial message
# execute if score .timer tutorial matches 250 run scoreboard players set @a SS_ui_tutorial 0

# count the number of players vs the number of tamed astromechs
# when 0, continue
execute if score .timer tutorial matches 1.. run scoreboard players set .count tutorial 0
execute if score .timer tutorial matches 1.. run execute as @a run scoreboard players add .count tutorial 1
execute if score .timer tutorial matches 1.. run execute as @e[type=spark:astromech,tag=tamed] run scoreboard players remove .count tutorial 1

execute if score .timer tutorial matches 1.. if score .count tutorial matches 1.. run titleraw @s actionbar {"rawtext":[{ "text": "hud:hint:" },{"translate":"intro.training_room.tutorial_message.waiting.message1", "with": [ "\n" ] }]}

execute if score .timer tutorial matches 1.. if score .count tutorial matches 1.. run scoreboard players set .all_done tutorial 0
execute if score .timer tutorial matches 1.. if score .count tutorial matches 0 run scoreboard players add .all_done tutorial 1

execute if score .all_done tutorial matches 10.. if score .count tutorial matches 0 run titleraw @a actionbar {"rawtext":[{ "text": "hud:clear" }]}
execute if score .all_done tutorial matches 10.. if score .count tutorial matches 0 run scoreboard players set @a SS_ui_task 0
execute if score .all_done tutorial matches 10.. if score .count tutorial matches 0 run function spark/tutorial/next