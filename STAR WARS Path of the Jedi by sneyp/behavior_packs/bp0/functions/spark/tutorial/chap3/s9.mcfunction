# © Spark Universe, 2023
# authors: William Savage
# description: runs 20/s 
# called by: chap3/loop

# need to spread players, then teleport to the correct y level
# execute if score .timer tutorial matches 1 run spreadplayers 3028 3071 3 8 @a
# execute if score .timer tutorial matches 1 run execute as @a as @s run tp ~ -56 ~

# close small door outside
execute if score .timer tutorial matches 1 positioned 3028 -56 3045 run event entity @e[type=spark:crucible_gate_small,r=1,c=1] spark:close_door

# remove tags
execute if score .timer tutorial matches 1 run tag @a remove instance_finished
execute if score .timer tutorial matches 1 run tag @a remove train_room_1
execute if score .timer tutorial matches 1 run tag @a remove train_room_2
execute if score .timer tutorial matches 1 run tag @a remove train_room_3
execute if score .timer tutorial matches 1 run tag @a remove train_room_4

# disable camera, set players to spectator?
#execute if score .timer tutorial matches 20 run inputpermission set @a movement disabled

# do shaking stuff
execute if score .timer tutorial matches 45 run camerashake add @a 1 20 positional

# play sounds
execute if score .timer tutorial matches 45 run playsound sound.spark.screenshake_crash @a 
execute if score .timer tutorial matches 46 run music stop 3.0  
execute if score .timer tutorial matches 47 run music play sound.spark.music.LowTensionCrucible 1.0 0.1 loop

# back screen
execute if score .timer tutorial matches 120 run title @a actionbar hud:fade_out_1

# teleport outside of training room
execute if score .timer tutorial matches 150 run tp @a 3028 -56 3054 180 0
execute if score .timer tutorial matches 145 positioned 3028 -56 3057 run event entity @e[type=spark:crucible_gate_large,r=1,c=1] spark:close_door

# more fade sounds
execute if score .timer tutorial matches 151 run playsound sound.spark.transitioner_fade_general @a

# spawn in huyang
execute if score .timer tutorial matches 155 run function spark/tutorial/next