### main loop of cutscene ch09 c01
# called like: execute if score .timer CS_timer matches X run X 
# duration: 715 ticks


## visibility
execute if score .timer CS_timer matches 20.. run effect @a[tag=!dev] invisibility 1 1 true
execute if score .timer CS_timer matches 20 run event entity @a[tag=!dev] spark:set_in_cutscene

execute if score .timer CS_timer matches 20 run function spark/cutscene/inv_clear
execute if score .timer CS_timer matches 712 run function spark/cutscene/inv_fill

## final player location - handled in droid start function
execute if score .timer CS_timer matches 713 run tp @a[tag=!dev] 8825 102 -10 180 0

## sound


## UI
execute if score .timer CS_timer matches 20 run tag @a[tag=!dev] add hide_ui
# execute if score .timer CS_timer matches 0 run title @a[tag=!dev] actionbar hud:fade_out_1
execute if score .timer CS_timer matches 21 run title @a[tag=!dev] actionbar hud:blackbars_in

execute if score .timer CS_timer matches 692 run title @a[tag=!dev] actionbar hud:blackbars_out
execute if score .timer CS_timer matches 714 run title @a[tag=!dev] actionbar hud:fade_in_1
execute if score .timer CS_timer matches 713 run tag @a[tag=!dev] remove hide_ui

# display  planet name
execute if score .timer CS_timer matches 117 run title @a[tag=!dev] actionbar hud:planet:kamino
execute if score .timer CS_timer matches 217 run title @a[tag=!dev] actionbar hud:blackbars


## models and triggers
execute if score .timer CS_timer matches 716 run tickingarea remove tmp.cutscene.0
execute if score .timer CS_timer matches 716 run tickingarea remove tmp.cutscene.1

# shot 1
execute if score .timer CS_timer matches 20 run playsound sound.spark.cutscene.hyperspace_exit @a
execute if score .timer CS_timer matches 21 run summon spark:skybox_static 5997.5 65 -0.5 0 0 spark:set_planet_space
execute if score .timer CS_timer matches 21 run summon spark:cutscene.eta2_to_planet 5997.5 65 -0.5 0 0 spark:stage_kamino
execute if score .timer CS_timer matches 230 run event entity @e[type=spark:cutscene.eta2_to_planet] spark:despawn
execute if score .timer CS_timer matches 230 run event entity @e[type=spark:skybox_static] spark:despawn
# shot 2
execute if score .timer CS_timer matches 215 run playsound sound.spark.cutscene.arrive_kamino @a
execute if score .timer CS_timer matches 213 run particle spark:kamino_waves_scene 8823.73 56.55 142.66
execute if score .timer CS_timer matches 217 run particle spark:kamino_waves_scene 8823.73 56.55 142.66
execute if score .timer CS_timer matches 225 run particle spark:kamino_waves_scene 8823.73 56.55 142.66
execute if score .timer CS_timer matches 237 run particle spark:kamino_waves_scene 8823.73 56.55 142.66

execute if score .timer CS_timer matches 211 run event entity @e[type=spark:cutscene.eta2] spark:despawn
execute if score .timer CS_timer matches 441 run summon spark:cutscene.eta2 9136.5 101 -64.5 0 0 spark:stage_ch09_c01_s2
execute if score .timer CS_timer matches 442 run effect @e[type=spark:cutscene.eta2] invisibility 1 1 true
execute if score .timer CS_timer matches 712 run event entity @e[type=spark:cutscene.eta2] spark:despawn

execute if score .timer CS_timer matches 714 run summon spark:cutscene.eta2 9136.5 100 -64.5 0 0



## camera
# shot 1
# shot 1 , reset skyboxes and summon static black one, camera command shot, set and reset cam busy for players
execute if score .timer CS_timer matches 20 run tp @a[tag=!dev] 5997.5 65 -0.5 0 0
execute if score .timer CS_timer matches 21 run event entity @a[tag=!dev] spark:set_cam_used
execute if score .timer CS_timer matches 21..210 run function spark/cutscene/shots/ch02_c11_s1
execute if score .timer CS_timer matches 210 run event entity @a[tag=!dev] spark:reset_cam_used
# shot 2
execute if score .timer CS_timer matches 215 run camera @a[tag=!dev] set minecraft:first_person 
execute if score .timer CS_timer matches 212..712 run function spark/cutscene/shots/ch09_c01_s2

## timer management
# reset
execute if score .timer CS_timer matches 715 run function spark/cutscene/setup
# timer
scoreboard players add .timer CS_timer 1    