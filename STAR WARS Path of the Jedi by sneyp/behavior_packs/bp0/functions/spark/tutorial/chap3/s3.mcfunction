# © Spark Universe, 2023
# authors: William Savage
# description: runs 20/s 
# called by: chap3/loop

# cutscene, walk entity to predefined point

# fades before teleports and stuff
# execute if score .timer tutorial matches 0 run title @a actionbar hud:fade_out_1
execute if score .timer tutorial matches 0 run scoreboard players set @a SS_ui_tutorial 0

# close door
execute if score .timer tutorial matches 20 positioned 3036 -56 3033 run event entity @e[type=spark:crucible_gate_large,r=1,c=1] spark:close_door


# execute if score .timer tutorial matches 50 run title @a actionbar hud:fade_in_1

# UPDATE
# lock player in a given place while this is running
# this will consist of the walkout, and the hologram!

# teleport
# execute if score .timer tutorial matches 20 run tp @a 3024.82 -55.36 3033.42 94.2 4.7
# execute if score .timer tutorial matches 20 run inputpermission set @a movement disabled
# execute if score .timer tutorial matches 20 run inputpermission set @a camera disabled

# summon breadcrumbs
# execute if score .timer tutorial matches 21 run summon spark:breadcrumb_1 3003 -56 3035
# execute if score .timer tutorial matches 22 run summon spark:breadcrumb_2 3015 -56 3033
# execute if score .timer tutorial matches 23 run summon spark:breadcrumb_3 3019 -56 3025
# execute if score .timer tutorial matches 24 run summon spark:breadcrumb_4 3024 -56 3031

# play sounds
# execute if score .timer tutorial matches 20 run gamemode spectator @a
# execute if score .timer tutorial matches 20 run playsound sound.spark.cutscene_huyang_appearing @a
# execute if score .timer tutorial matches 20 run music stop 1.0
# execute if score .timer tutorial matches 21 run music play sound.spark.music_yoda_younglings1 1.0 0.1 loop

# execute if score .timer tutorial matches 21 run say TODO: implement, playing master huyang walkout and hologram cutscene 
execute if score .timer tutorial matches 1 run function spark/cutscene/start_ch02_c07
# execute if score .timer tutorial matches 280 run title @a actionbar hud:fade_out_1

# teleport master huyang 
# execute if score .timer tutorial matches 299 run tp @e[c=1,type=spark:master_huyang] 3019.44 -56.00 3033.48

# wait for a while
execute if score .timer tutorial matches 336 run function spark/tutorial/next
