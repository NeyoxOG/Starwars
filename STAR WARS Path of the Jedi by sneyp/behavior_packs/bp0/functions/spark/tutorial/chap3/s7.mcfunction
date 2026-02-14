# © Spark Universe, 2023
# authors: William Savage
# description: runs 20/s 
# called by: chap3/loop

# moving from the work room to the training instance

# new doors
# large training room 3028 -56 3057 north
# large 3034 -56 3051 east
# large 2964 -56 3051 east
# large 2999 -56 3057 north
# large 2999 -56 3045 north
# large 2970 -56 3045 north
# large droid room 2970 -56 3057 north

#
execute if score .timer tutorial matches 9 run setblock 3027 -55 3045 spark:barrier_vertical_slab["minecraft:cardinal_direction"="west"]
execute if score .timer tutorial matches 9 run setblock 3029 -55 3045 spark:barrier_vertical_slab["minecraft:cardinal_direction"="east"]

# CLEAR .COUNT, tag=ignited
execute if score .timer tutorial matches 1 run tag @a remove ignited
execute if score .timer tutorial matches 1 run scoreboard players reset .ignited tutorial
execute if score .timer tutorial matches 1 run scoreboard players reset @a tutorial

# reset kelleran_beq interact stuff
execute if score .timer tutorial matches 1 positioned 3027.52 -56.00 3033.56 run event entity @e[type=spark:kelleran_beq,c=1,r=1] spark:reset_npc

# spawn new doors
#execute if score .timer tutorial matches 2 run summon spark:crucible_gate_large 3028 -56 3057.18 0 0 spark:door_north

#execute if score .timer tutorial matches 3 run summon spark:crucible_gate_large 3034.18 -56 3051 0 0 spark:door_east
#execute if score .timer tutorial matches 4 run summon spark:crucible_gate_large 2964.82 -56 3051 0 0 spark:door_east

#execute if score .timer tutorial matches 5 run summon spark:crucible_gate_large 2999 -56 3057.18 0 0 spark:door_north
#execute if score .timer tutorial matches 6 run summon spark:crucible_gate_large 2999 -56 3045.82 0 0 spark:door_north
#execute if score .timer tutorial matches 7 run summon spark:crucible_gate_large 2970 -56 3045.82 0 0 spark:door_north
#execute if score .timer tutorial matches 8 run summon spark:crucible_gate_large 2970 -56 3057.18 0 0 spark:door_north


# set task on screen for player
#execute if score .timer tutorial matches 2 run scoreboard players set @a SS_ui_task 4

# send a tutorial message to players, remove some time later
execute if score .timer tutorial matches 2 run scoreboard players set @a SS_ui_tutorial 8

# play sounds
execute if score .timer tutorial matches 2 run playsound sound.spark.quest_minor @a 

# open side door and work room entrence door (for catchup)
# execute if score .timer tutorial matches 5 positioned 3036 -56 3033 run event entity @e[type=spark:crucible_gate_large,c=1,r=1] spark:open_door
execute if score .timer tutorial matches 5 positioned 3028 -56 3045 run event entity @e[type=spark:crucible_gate_small,c=1,r=1] spark:open_door

# open training room door when player is in hallway
execute if entity @a[x=3033,y=-48,z=3046,dx=-10,dy=-12,dz=11] positioned 3028 -56 3057 run event entity @e[type=spark:crucible_gate_large,r=1,c=1] spark:open_door

# lights should be off in the training room

# when players enter, count them and when all active players are in there, do the instance stuff
scoreboard players set .count tutorial 0
execute as @a[x=3042,y=-44,z=3057,dx=-28,dy=-16,dz=28] run scoreboard players add .count tutorial 1
execute as @a run scoreboard players remove .count tutorial 1

# if we are waiting, notify the player
execute if score .count tutorial matches 1.. run titleraw @a[x=3042,y=-44,z=3057,dx=-28,dy=-16,dz=28] actionbar {"rawtext":[{ "text": "hud:hint:" },{"translate":"intro.training_room.tutorial_message.waiting.message1", "with": [ "\n" ] }]}

# if 0, we are all in
execute if score .count tutorial matches 0 run titleraw @a actionbar {"rawtext":[{ "text": "hud:clear" }]}
execute if score .count tutorial matches 0 run function spark/tutorial/next
