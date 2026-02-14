# © Spark Universe, 2023
# authors: William Savage
# description: for each player waiting to be assigned to an instnace, runs 20/s 
# called by: chap3/s10

# positions
# 3028 -56 3140 a1
# 3028 -56 3209 a2
# 3028 -56 3278 a3
# 3028 -56 3347 a4 (designed from this location) 

# detect activity
# execute positioned 3028 -56 3140 if entity @a[r=20] run scoreboard players set .active1 tut_instances 1
# execute positioned 3028 -56 3209 if entity @a[r=20] run scoreboard players set .active2 tut_instances 1
# execute positioned 3028 -56 3278 if entity @a[r=20] run scoreboard players set .active3 tut_instances 1
# execute positioned 3028 -56 3347 if entity @a[r=20] run scoreboard players set .active4 tut_instances 1

# assign via increment, tag, step and teleport
execute if entity @s[tag=!assigned] if score .active1 tut_instances matches 0 run scoreboard players set @s tut_instances 0
execute if entity @s[tag=!assigned] if score .active1 tut_instances matches 0 run scoreboard players set @s tut_i_times 0
execute if entity @s[tag=!assigned] if score .active1 tut_instances matches 0 run scoreboard players set @s tut_i_counter 61
execute if entity @s[tag=!assigned] if score .active1 tut_instances matches 0 run scoreboard players set @s tut_i_bots 0
execute if entity @s[tag=!assigned] if score .active1 tut_instances matches 0 run scoreboard players set @s tut_i_deflect 0
execute if entity @s[tag=!assigned] if score .active1 tut_instances matches 0 run teleport @s 3028 -54 3128
execute if entity @s[tag=!assigned] if score .active1 tut_instances matches 0 run tag @s add assigned_temp
execute if entity @s[tag=!assigned] if score .active1 tut_instances matches 0 run tag @s add train_room_1
execute if entity @s[tag=!assigned] if score .active1 tut_instances matches 0 run scoreboard players set .active1 tut_instances 1
tag @s[tag=assigned_temp] add assigned

execute if entity @s[tag=!assigned] if score .active2 tut_instances matches 0 run scoreboard players set @s tut_instances 0
execute if entity @s[tag=!assigned] if score .active2 tut_instances matches 0 run scoreboard players set @s tut_i_times 0
execute if entity @s[tag=!assigned] if score .active2 tut_instances matches 0 run scoreboard players set @s tut_i_counter 61
execute if entity @s[tag=!assigned] if score .active2 tut_instances matches 0 run scoreboard players set @s tut_i_bots 0
execute if entity @s[tag=!assigned] if score .active2 tut_instances matches 0 run scoreboard players set @s tut_i_deflect 0
execute if entity @s[tag=!assigned] if score .active2 tut_instances matches 0 run teleport @s 3028 -54 3197
execute if entity @s[tag=!assigned] if score .active2 tut_instances matches 0 run tag @s add assigned_temp
execute if entity @s[tag=!assigned] if score .active1 tut_instances matches 0 run tag @s add train_room_2
execute if entity @s[tag=!assigned] if score .active2 tut_instances matches 0 run scoreboard players set .active2 tut_instances 1
tag @s[tag=assigned_temp] add assigned

execute if entity @s[tag=!assigned] if score .active3 tut_instances matches 0 run scoreboard players set @s tut_instances 0
execute if entity @s[tag=!assigned] if score .active3 tut_instances matches 0 run scoreboard players set @s tut_i_times 0
execute if entity @s[tag=!assigned] if score .active3 tut_instances matches 0 run scoreboard players set @s tut_i_counter 61
execute if entity @s[tag=!assigned] if score .active3 tut_instances matches 0 run scoreboard players set @s tut_i_bots 0
execute if entity @s[tag=!assigned] if score .active3 tut_instances matches 0 run scoreboard players set @s tut_i_deflect 0
execute if entity @s[tag=!assigned] if score .active3 tut_instances matches 0 run teleport @s 3028 -54 3266
execute if entity @s[tag=!assigned] if score .active3 tut_instances matches 0 run tag @s add assigned_temp
execute if entity @s[tag=!assigned] if score .active1 tut_instances matches 0 run tag @s add train_room_3
execute if entity @s[tag=!assigned] if score .active3 tut_instances matches 0 run scoreboard players set .active3 tut_instances 1
tag @s[tag=assigned_temp] add assigned

execute if entity @s[tag=!assigned] if score .active4 tut_instances matches 0 run scoreboard players set @s tut_instances 0
execute if entity @s[tag=!assigned] if score .active4 tut_instances matches 0 run scoreboard players set @s tut_i_times 0
execute if entity @s[tag=!assigned] if score .active4 tut_instances matches 0 run scoreboard players set @s tut_i_counter 61
execute if entity @s[tag=!assigned] if score .active4 tut_instances matches 0 run scoreboard players set @s tut_i_bots 0
execute if entity @s[tag=!assigned] if score .active4 tut_instances matches 0 run scoreboard players set @s tut_i_deflect 0
execute if entity @s[tag=!assigned] if score .active4 tut_instances matches 0 run teleport @s 3028 -54 3335
execute if entity @s[tag=!assigned] if score .active4 tut_instances matches 0 run tag @s add assigned_temp
execute if entity @s[tag=!assigned] if score .active1 tut_instances matches 0 run tag @s add train_room_4
execute if entity @s[tag=!assigned] if score .active4 tut_instances matches 0 run scoreboard players set .active4 tut_instances 1
tag @s[tag=assigned_temp] add assigned

tag @s remove assigned_temp

# if full, for now just smal them in chat to see if it works :D

execute if score .active1 tut_instances matches 1 if score .active2 tut_instances matches 1 if score .active3 tut_instances matches 1 if score .active4 tut_instances matches 1 run tell @s We full (dev)