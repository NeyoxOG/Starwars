### main loop of cutscene ch08 c11  - flying to tatooine
# called like: execute if score .timer CS_timer matches X run X 
# duration: 500 ticks


## visibility
execute if score .timer CS_timer matches 20.. run effect @a[tag=!dev] invisibility 1 1 true
execute if score .timer CS_timer matches 20 run event entity @a[tag=!dev] spark:set_in_cutscene



execute if score .timer CS_timer matches 20 run function spark/cutscene/inv_clear
execute if score .timer CS_timer matches 476 run function spark/cutscene/inv_fill

## final player location
execute if score .timer CS_timer matches 473 run tp @a[tag=!dev] 6330.78 158.00 5958.33 4.96 2.30
# set eta-2 + barriers


## sound
execute if score .timer CS_timer matches 20 run music stop 2.0


## UI
execute if score .timer CS_timer matches 20 run tag @a[tag=!dev] add hide_ui
# execute if score .timer CS_timer matches 0 run title @a[tag=!dev] actionbar hud:fade_out_1
execute if score .timer CS_timer matches 22 run title @a[tag=!dev] actionbar hud:blackbars_in

execute if score .timer CS_timer matches 452 run camera @a[tag=!dev] fade time 0.5 0.8 0.8
execute if score .timer CS_timer matches 462 run title @a[tag=!dev] actionbar hud:blackbars_out
execute if score .timer CS_timer matches 475 run tag @a[tag=!dev] remove hide_ui

# display  planet name 
execute if score .timer CS_timer matches 117 run title @a[tag=!dev] actionbar hud:planet:tatooine
execute if score .timer CS_timer matches 217 run title @a[tag=!dev] actionbar hud:blackbars


## models and triggers
execute if score .timer CS_timer matches 475 run tickingarea remove tmp.cutscene.0
execute if score .timer CS_timer matches 475 run tickingarea remove tmp.cutscene.1
execute if score .timer CS_timer matches 475 run tickingarea remove tmp.cutscene.2

# shot 1
execute if score .timer CS_timer matches 20 run playsound sound.spark.cutscene.hyperspace_exit @a
execute if score .timer CS_timer matches 21 run summon spark:skybox_static 5997.5 65 -0.5 0 0 spark:set_planet_space
execute if score .timer CS_timer matches 21 run summon spark:cutscene.eta2_to_planet 5997.5 65 -0.5 0 0 spark:stage_tatooine
execute if score .timer CS_timer matches 230 run event entity @e[type=spark:cutscene.eta2_to_planet] spark:despawn
execute if score .timer CS_timer matches 230 run event entity @e[type=spark:skybox_static] spark:despawn


# shot 2
execute if score .timer CS_timer matches 220 run playsound sound.spark.cutscene.arrive_tatooine @a
execute if score .timer CS_timer matches 200 run event entity @e[type=spark:cutscene.eta2] spark:despawn
execute if score .timer CS_timer matches 211 run summon spark:cutscene.eta2 6354.5 159 5952.5 150 0 spark:stage_ch08_c01_s2

execute if score .timer CS_timer matches 472 run event entity @e[type=spark:cutscene.eta2] spark:despawn
execute if score .timer CS_timer matches 475 run summon spark:cutscene.eta2 6334.5 159 5952.5 60 0


## camera
# shot 1
# shot 1 , reset skyboxes and summon static black one, camera command shot, set and reset cam busy for players
execute if score .timer CS_timer matches 20 run tp @a[tag=!dev] 5997.5 65 -0.5 0 0
execute if score .timer CS_timer matches 21 run event entity @a[tag=!dev] spark:set_cam_used
execute if score .timer CS_timer matches 21..210 run function spark/cutscene/shots/ch02_c11_s1
execute if score .timer CS_timer matches 210 run event entity @a[tag=!dev] spark:reset_cam_used
# shot 2 - 261 ticks length
execute if score .timer CS_timer matches 215 run camera @a[tag=!dev] set minecraft:first_person 
execute if score .timer CS_timer matches 211..472 run effect @a[tag=!dev] slowness 1 4 true
execute if score .timer CS_timer matches 211..472 run function spark/cutscene/shots/ch08_c01_s2


## timer management
# reset
execute if score .timer CS_timer matches 480 run function spark/cutscene/setup
# timer
scoreboard players add .timer CS_timer 1
