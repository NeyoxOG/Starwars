### main loop of cutscene ch07 c02 and c03
# called like: execute if score .timer CS_timer matches X run X 
# duration: 895 ticks


## visibility
execute if score .timer CS_timer matches 20.. run effect @a[tag=!dev] invisibility 1 1 true
effect @a[tag=!dev] slow_falling 1 254 true
execute if score .timer CS_timer matches 20 run event entity @a[tag=!dev] spark:set_in_cutscene


## final player location
# execute if score .timer CS_timer matches 891 run tp @a[tag=!dev] 5999 61 -2 0 0
execute if score .timer CS_timer matches 20 run function spark/cutscene/inv_clear

# why is this here!
# execute if score .timer CS_timer matches 890 run function spark/cutscene/inv_fill


## sound
execute if score .timer CS_timer matches 10 run music stop 5.0
execute if score .timer CS_timer matches 18 run playsound sound.spark.cutscene.venator_kidnapping @a
execute if score .timer CS_timer matches 344 run music stop 0.1
execute if score .timer CS_timer matches 369 run music play sound.spark.music.QueenAmidala

## UI
execute if score .timer CS_timer matches 20 run tag @a[tag=!dev] add hide_ui
# execute if score .timer CS_timer matches 0 run title @a[tag=!dev] actionbar hud:fade_out_1
execute if score .timer CS_timer matches 21 run title @a[tag=!dev] actionbar hud:blackbars_in


execute if score .timer CS_timer matches 210 run title @a[tag=!dev] actionbar hud:blackbars_out
execute if score .timer CS_timer matches 260 run title @a[tag=!dev] actionbar hud:blackbars_in

execute if score .timer CS_timer matches 590 run title @a[tag=!dev] actionbar hud:blackbars_out
execute if score .timer CS_timer matches 631 run title @a[tag=!dev] actionbar hud:blackbars_in

execute if score .timer CS_timer matches 810 run title @a[tag=!dev] actionbar hud:blackbars_out
# execute if score .timer CS_timer matches 892 run title @a[tag=!dev] actionbar hud:fade_in_1
execute if score .timer CS_timer matches 889 run tag @a[tag=!dev] remove hide_ui


## models and triggers
# load
execute if score .timer CS_timer matches 892 run tickingarea remove tmp.cutscene.0
execute if score .timer CS_timer matches 892 run tickingarea remove tmp.cutscene.1
execute if score .timer CS_timer matches 892 run tickingarea remove tmp.cutscene.2
execute if score .timer CS_timer matches 892 run tickingarea remove tmp.cutscene.3
execute if score .timer CS_timer matches 892 run tickingarea remove tmp.cutscene.4

# models
execute if score .timer CS_timer matches 10 run summon spark:skybox_static 5975.5 -49.5 2601.5 0 0 spark:set_planet_space
execute if score .timer CS_timer matches 12 run event entity @e[type=spark:skybox_static] spark:set_size_mini
execute if score .timer CS_timer matches 19 run summon spark:cutscene.gunship 5975.5 -49.5 2601.5 90 0 spark:stage_shot_1
execute if score .timer CS_timer matches 110 run event entity @e[type=spark:cutscene.gunship] spark:despawn

execute if score .timer CS_timer matches 100 run summon spark:skybox_static 5910.5 -55.00 2601.5 0 0 spark:set_planet_space
execute if score .timer CS_timer matches 112 run summon spark:cutscene.gunship 5910.5 -55.00 2601.5 90 0 spark:stage_shot_2
execute if score .timer CS_timer matches 235 run event entity @e[type=spark:cutscene.gunship] spark:despawn

# particles
execute if score .timer CS_timer matches 610 run particle spark:dreadnaught_outside_shield_r 193.5 100.50 24.5
execute if score .timer CS_timer matches 610 run particle spark:dreadnaught_outside_shield_m 214.5 100.50 24.5
execute if score .timer CS_timer matches 610 run particle spark:dreadnaught_outside_shield_l 235.5 100.50 24.5

# capture 1
execute if score .timer CS_timer matches 200 run summon spark:skybox_static 6005.5 65 20.5 0 0 spark:set_planet_space
execute if score .timer CS_timer matches 250 run summon spark:cutscene.gunship 5997.5 65 -0.5 0 0 spark:stage_capture_1
execute if score .timer CS_timer matches 338 run event entity @e[type=spark:cutscene.gunship] spark:despawn
# capture 2
execute if score .timer CS_timer matches 339 run summon spark:cutscene.gunship 5997.5 65 -0.5 180 0 spark:stage_capture_2
execute if score .timer CS_timer matches 390 run particle spark:dreadnought 5840 73 43
execute if score .timer CS_timer matches 623 run event entity @e[type=spark:cutscene.gunship] spark:despawn

# capture 3

### set here sttaic skybox at camera location

execute if score .timer CS_timer matches 610 run summon spark:skybox_static 191 98 28 0 0 spark:set_planet_space
execute if score .timer CS_timer matches 624 run summon spark:cutscene.gunship 216 99.5 6 180 0 spark:stage_capture_3
execute if score .timer CS_timer matches 890 run event entity @e[type=spark:cutscene.gunship] spark:despawn

execute if score .timer CS_timer matches 890 run event entity @e[type=spark:skybox_static] spark:despawn

## camera
# shot 1: 100
execute if score .timer CS_timer matches 20..110 run effect @a[tag=!dev] slowness 1 1 true
execute if score .timer CS_timer matches 21..111 run function spark/cutscene/shots/ch07_c02_s1
execute if score .timer CS_timer matches 111 run scoreboard players set .timer_shot CS_timer 0
# shot 2: 121
execute if score .timer CS_timer matches 112..233 run effect @a[tag=!dev] slowness 1 4 true
execute if score .timer CS_timer matches 112..233 run function spark/cutscene/shots/ch07_c02_s2

# shot 3 _ 1 : 88
execute if score .timer CS_timer matches 244 run event entity @a[tag=!dev] spark:set_cam_used
execute if score .timer CS_timer matches 244 run tp @a[tag=!dev] 5997.5 65 -0.5
execute if score .timer CS_timer matches 255..343 run function spark/cutscene/shots/ch07_c02_s3_1
# shot 3 - 2 : 284
execute if score .timer CS_timer matches 343 run scoreboard players set .timer_shot CS_timer 0
execute if score .timer CS_timer matches 343..628 run function spark/cutscene/shots/ch07_c02_s3_2
# shot 3 - 3 : 260
execute if score .timer CS_timer matches 628 run tp @a[tag=!dev] 191.52 98.00 23.27
execute if score .timer CS_timer matches 629..889 run function spark/cutscene/shots/ch07_c02_s3_3
execute if score .timer CS_timer matches 890 run event entity @a[tag=!dev] spark:reset_cam_used

# other stuff
execute if score .timer CS_timer matches 20 run clear @a

## timer management
# reset
execute if score .timer CS_timer matches 895 run function spark/cutscene/setup
# timer
scoreboard players add .timer CS_timer 1