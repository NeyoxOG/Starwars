# © Spark Universe, 2023
# authors: William Savage
# description: runs 20/s 
# called by: chap3/loop

# disable npc interact
execute if score .timer tutorial matches 1 positioned 3025 -56 3050 run event entity @e[type=spark:master_huyang,c=1,r=1] spark:reset_npc

# set task 8 and play sound
execute if score .timer tutorial matches 5 run scoreboard players set @a SS_ui_task 8
execute if score .timer tutorial matches 5 run playsound sound.spark.quest_medium @a

# set tutorial message
execute if score .timer tutorial matches 35 run scoreboard players set @a SS_ui_tutorial 14
#execute if score .timer tutorial matches 200 run scoreboard players set @a SS_ui_tutorial 0

# detect when a player is near the door to the room
# open door and spawn in things
execute if score .timer tutorial matches 5.. if entity @a[x=2975,y=-56,z=3048,dx=-11,dy=5,dz=9,c=1] positioned 2970 -57 3057 run event entity @e[type=spark:crucible_gate_large,r=20,c=1] spark:open_door

# summon all of the stuff!
# facing left rot 90 0
execute if score .timer tutorial matches 6 run summon spark:astromech 2975 -56 3062 90 0 spark:story_spawn
execute if score .timer tutorial matches 7 run summon spark:astromech 2975 -56 3066 90 0 spark:story_spawn
execute if score .timer tutorial matches 8 run summon spark:astromech 2975 -56 3074 90 0 spark:story_spawn
execute if score .timer tutorial matches 9 run summon spark:astromech 2975 -56 3078 90 0 spark:story_spawn
# facing right rot -90 0
execute if score .timer tutorial matches 10 run summon spark:astromech 2965 -56 3078 -90 0 spark:story_spawn
execute if score .timer tutorial matches 11 run summon spark:astromech 2965 -56 3074 -90 0 spark:story_spawn
execute if score .timer tutorial matches 12 run summon spark:astromech 2965 -56 3066 -90 0 spark:story_spawn
execute if score .timer tutorial matches 13 run summon spark:astromech 2965 -56 3062 -90 0 spark:story_spawn

#
execute if score .timer tutorial matches 6 run summon spark:droid_room_table 2970.5 -56.00 3070.5 90 0

function spark/particles/crucible_crash

# npc
# execute if score .timer tutorial matches 10 run summon spark:ad_3 2970 -56 3081 180 0

# tools 
# execute if score .timer tutorial matches 11 run summon spark:companion_item 2971 -55 3067 0 0 spark:set_paint_tool
# execute if score .timer tutorial matches 12 run summon spark:companion_item 2969 -55 3068 0 0 spark:set_pattern_tool
# execute if score .timer tutorial matches 13 run summon spark:companion_item 2971 -55 3070 0 0 spark:set_head_tool
# execute if score .timer tutorial matches 14 run summon spark:companion_item 2970 -55 3073 0 0 spark:set_power_cell

# detect when atleast one player is within the area, goto next
execute if score .timer tutorial matches 5.. if entity @a[x=2978,y=-57,z=3058.2,dx=-16,dy=6,dz=28,c=1] run function spark/tutorial/next