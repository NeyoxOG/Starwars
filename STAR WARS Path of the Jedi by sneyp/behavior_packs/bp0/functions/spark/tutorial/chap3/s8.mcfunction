# © Spark Universe, 2023
# authors: William Savage
# description: runs 20/s 
# called by: chap3/loop


# this handles updating, assigning and deassigning instances

# create the instance board and set defaults
scoreboard objectives add tut_instances dummy
scoreboard players add .active1 tut_instances 0
scoreboard players add .active2 tut_instances 0
scoreboard players add .active3 tut_instances 0
scoreboard players add .active4 tut_instances 0

scoreboard objectives add tut_i_times dummy
scoreboard objectives add tut_i_counter dummy
scoreboard objectives add tut_i_bots dummy

scoreboard players set .twenty tut_i_counter 20

# detect activity
execute positioned 3028 -56 3140 if entity @a[r=20] run scoreboard players set .active1 tut_instances 1
execute positioned 3028 -56 3209 if entity @a[r=20] run scoreboard players set .active2 tut_instances 1
execute positioned 3028 -56 3278 if entity @a[r=20] run scoreboard players set .active3 tut_instances 1
execute positioned 3028 -56 3347 if entity @a[r=20] run scoreboard players set .active4 tut_instances 1


# the fading for this section
execute if score .timer tutorial matches 1 run scoreboard players set @a SS_ui_tutorial 0

execute if score .timer tutorial matches 1 run effect @a resistance 999999 5 true
execute if score .timer tutorial matches 1 run title @a actionbar hud:fade_out_1
execute if score .timer tutorial matches 1 run playsound sound.spark.transitioner_fade_general @a
  
# execute on each player within the training area, if they do not have an 'assigned' tag, transport them to an empty instance
execute if score .timer tutorial matches 25.. as @a[x=3028,y=-56,z=3057,r=25,tag=!assigned,tag=!instance_finished] run function spark/tutorial/chap3/_assign 

# queue music here as we cannot set music per client (i dont think)
# execute if score .timer tutorial matches 25 run music stop 1.0
# execute if score .timer tutorial matches 25 run music play sound.spark.music_war_plans 1.0 0.1 loop

# update each arena if there is a player in there
execute if score .timer tutorial matches 25.. positioned 3028 -56 3140 if entity @a[r=20,c=1,tag=!instance_finished] as @a[r=20,c=1] run function spark/tutorial/chap3/_iloop
execute if score .timer tutorial matches 25.. positioned 3028 -56 3209 if entity @a[r=20,c=1,tag=!instance_finished] as @a[r=20,c=1] run function spark/tutorial/chap3/_iloop
execute if score .timer tutorial matches 25.. positioned 3028 -56 3278 if entity @a[r=20,c=1,tag=!instance_finished] as @a[r=20,c=1] run function spark/tutorial/chap3/_iloop
execute if score .timer tutorial matches 25.. positioned 3028 -56 3347 if entity @a[r=20,c=1,tag=!instance_finished] as @a[r=20,c=1] run function spark/tutorial/chap3/_iloop

execute if score .timer tutorial matches 25.. positioned 3028 -86 3140 run tp @a[r=20,c=1,tag=!instance_finished] 3028 -54 3128
execute if score .timer tutorial matches 25.. positioned 3028 -86 3209 run tp @a[r=20,c=1,tag=!instance_finished] 3028 -54 3197
execute if score .timer tutorial matches 25.. positioned 3028 -86 3278 run tp @a[r=20,c=1,tag=!instance_finished] 3028 -54 3266
execute if score .timer tutorial matches 25.. positioned 3028 -86 3347 run tp @a[r=20,c=1,tag=!instance_finished] 3028 -54 3335

# end to this state

# count the number of players who have the instance_finished tag, if they match the number of players... we are good to continue
execute if score .timer tutorial matches 25.. run scoreboard players set .count tutorial 0
execute if score .timer tutorial matches 25.. run execute as @a run scoreboard players add .count tutorial 1
execute if score .timer tutorial matches 25.. run execute as @a[tag=instance_finished] run scoreboard players remove .count tutorial 1

# if 1.., play a waiting message for those who are waiting
execute if score .timer tutorial matches 25.. if score .count tutorial matches 1.. run scoreboard players set @a[tag=instance_finished] SS_ui_tutorial 13

# if ..0, move onto the next section
# also despawn some mobs and close a door!
#execute if score .timer tutorial matches 25.. if score .count tutorial matches ..0 positioned 3028 -56 3045 run event entity @e[type=spark:crucible_gate_small,c=1,r=1] spark:close_door
#execute if score .timer tutorial matches 25.. if score .count tutorial matches ..0 positioned 3028 -56 3057 run event entity @e[type=spark:crucible_gate_large,c=1,r=1] spark:close_door

execute if score .timer tutorial matches 25.. if score .count tutorial matches ..0 positioned 3027.52 -56.00 3033.56 run event entity @e[type=spark:kelleran_beq,c=1,r=1] spark:despawn
execute if score .timer tutorial matches 25.. if score .count tutorial matches ..0 positioned 3030 -56 3037 run event entity @e[type=spark:padawan_1,c=1,r=1] spark:despawn
execute if score .timer tutorial matches 25.. if score .count tutorial matches ..0 positioned 3027 -56 3036 run event entity @e[type=spark:padawan_2,c=1,r=1] spark:despawn
execute if score .timer tutorial matches 25.. if score .count tutorial matches ..0 positioned 3026 -56 3033 run event entity @e[type=spark:padawan_3,c=1,r=1] spark:despawn
execute if score .timer tutorial matches 25.. if score .count tutorial matches 1.. run scoreboard players set .end_time tutorial 0
execute if score .timer tutorial matches 25.. if score .count tutorial matches ..0 if entity @a[tag=instance_finished] run scoreboard players add .end_time tutorial 1
execute if score .end_time tutorial matches 20.. if score .count tutorial matches ..0 run function spark/tutorial/next

#
tp @a[tag=train_room_1,tag=death_can_respawn] 3028 -54 3128
tp @a[tag=train_room_2,tag=death_can_respawn] 3028 -54 3197
tp @a[tag=train_room_3,tag=death_can_respawn] 3028 -54 3266
tp @a[tag=train_room_4,tag=death_can_respawn] 3028 -54 3335
tag @a[tag=death_can_respawn] remove death_can_respawn