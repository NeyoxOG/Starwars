### main loop of cutscene ch02 c11 - Arrive on Coruscant
# called like: execute if score .timer CS_timer matches X run X 
# duration: 459 ticks


## visibility
execute if score .timer CS_timer matches 20.. run effect @a[tag=!dev] invisibility 1 1 true
execute if score .timer CS_timer matches 20 run event entity @a[tag=!dev] spark:set_in_cutscene



execute if score .timer CS_timer matches 20 run function spark/cutscene/inv_clear
execute if score .timer CS_timer matches 458 run function spark/cutscene/inv_fill

## final player location
# regular
execute if score .timer CS_timer matches 457 if score .cs_corusc_alt CS_trigger matches 0 run tp @a[tag=!dev] 3010.5 33 0.5 -90 0
# council
execute if score .timer CS_timer matches 457 if score .cs_corusc_alt CS_trigger matches 1 run tp @a[tag=!dev] 9200.5 37 8994.5 180 0
# archives
# execute if score .timer CS_timer matches 457 if score .cs_corusc_alt CS_trigger matches 2 run tp @a[tag=!dev] 8926.5 24.5 9159.5 90 0
execute if score .timer CS_timer matches 457 if score .cs_corusc_alt CS_trigger matches 2 run function spark/tutorial/game_end/start

## sound
execute if score .timer CS_timer matches 20 run music stop 6.0


## UI
execute if score .timer CS_timer matches 20 run tag @a[tag=!dev] add hide_ui
# execute if score .timer CS_timer matches 0 run title @a[tag=!dev] actionbar hud:fade_out_1
execute if score .timer CS_timer matches 21 run title @a[tag=!dev] actionbar hud:blackbars_in

execute if score .timer CS_timer matches 435 run title @a[tag=!dev] actionbar hud:blackbars_out

execute if score .timer CS_timer matches 458 if score .cs_corusc_alt CS_trigger matches ..1 run title @a[tag=!dev] actionbar hud:fade_in_1
execute if score .timer CS_timer matches 457 if score .cs_corusc_alt CS_trigger matches ..1 run tag @a[tag=!dev] remove hide_ui


# display  planet name
execute if score .timer CS_timer matches 117 run title @a[tag=!dev] actionbar hud:planet:coruscant
execute if score .timer CS_timer matches 217 run title @a[tag=!dev] actionbar hud:blackbars



## models and triggers
execute if score .timer CS_timer matches 458 run tickingarea remove tmp.cutscene.0
execute if score .timer CS_timer matches 458 run tickingarea remove tmp.cutscene.1
execute if score .timer CS_timer matches 458 run tickingarea remove tmp.cutscene.2

execute if score .timer CS_timer matches 21 run summon spark:skybox_static 5997.5 65 -0.5 0 0 spark:set_planet_space
execute if score .timer CS_timer matches 21 run summon spark:cutscene.eta2_to_planet 5997.5 65 -0.5 0 0 spark:stage_coruscant
execute if score .timer CS_timer matches 230 run event entity @e[type=spark:cutscene.eta2_to_planet] spark:despawn
execute if score .timer CS_timer matches 230 run event entity @e[type=spark:skybox_static] spark:despawn



execute if score .timer CS_timer matches 200 run event entity @e[type=spark:cutscene.eta2] spark:despawn
execute if score .timer CS_timer matches 211 run summon spark:cutscene.eta2 3100.5 34 0.5 -90 0 spark:stage_ch02_c11_s3
execute if score .timer CS_timer matches 454 run event entity @e[type=spark:cutscene.eta2] spark:despawn
execute if score .timer CS_timer matches 457 run summon spark:cutscene.eta2 3000.5 34 0.5 -90 0



## camera
# shot 1 , reset skyboxes and summon static black one, camera command shot, set and reset cam busy for players
execute if score .timer CS_timer matches 20 run playsound sound.spark.cutscene.hyperspace_exit @a
execute if score .timer CS_timer matches 20 run tp @a[tag=!dev] 5997.5 65 -0.5 0 0
execute if score .timer CS_timer matches 21 run event entity @a[tag=!dev] spark:set_cam_used
execute if score .timer CS_timer matches 21..210 run function spark/cutscene/shots/ch02_c11_s1
execute if score .timer CS_timer matches 210 run event entity @a[tag=!dev] spark:reset_cam_used
# shot 2 - canceled

# shot 3 + 143
execute if score .timer CS_timer matches 220 run playsound sound.spark.cutscene.arrive_coruscant @a
execute if score .timer CS_timer matches 215 run camera @a[tag=!dev] set minecraft:first_person 
execute if score ..timer CS_timer matches 200 run tp @a[tag=!dev] 3104.35 45.76 59.7 117.5 3.0
execute if score .timer CS_timer matches 211..454 run effect @a[tag=!dev] slowness 1 6 true 
execute if score .timer CS_timer matches 211 run scoreboard players set .timer_shot CS_timer 0
execute if score .timer CS_timer matches 211..454 run function spark/cutscene/shots/ch02_c11_s3


## timer management
# reset
execute if score .timer CS_timer matches 459 if score .state tutorial matches 4.. if score .substate tutorial matches 4.. run scoreboard players set .hub glob_mission_state 1
execute if score .timer CS_timer matches 459 if score .state tutorial matches 4.. if score .substate tutorial matches 4.. run function spark/tutorial/chap4/quest_giver_task
execute if score .timer CS_timer matches 459 run function spark/cutscene/setup
# timer
scoreboard players add .timer CS_timer 1