### main loop of cutscene ch08 c11  - flying to felucia
# called like: execute if score .timer CS_timer matches X run X 
# duration: 500 ticks


## visibility
execute if score .timer CS_timer matches 20.. run effect @a[tag=!dev] invisibility 1 1 true
effect @a[tag=!dev] slow_falling 1 254 true
execute if score .timer CS_timer matches 20 run event entity @a[tag=!dev] spark:set_in_cutscene



execute if score .timer CS_timer matches 20 run function spark/cutscene/inv_clear
execute if score .timer CS_timer matches 496 run function spark/cutscene/inv_fill

## final player location
execute if score .timer CS_timer matches 493 run tp @a[tag=!dev] 8942.85 48.00 5747.15 facing 8947.66 48.00 5748.56
# set eta-2 + barriers


## sound
execute if score .timer CS_timer matches 20 run music stop 2.0


## UI
execute if score .timer CS_timer matches 20 run tag @a[tag=!dev] add hide_ui
# execute if score .timer CS_timer matches 0 run title @a[tag=!dev] actionbar hud:fade_out_1
execute if score .timer CS_timer matches 21 run title @a[tag=!dev] actionbar hud:blackbars_in

execute if score .timer CS_timer matches 472 run title @a[tag=!dev] actionbar hud:blackbars_out
execute if score .timer CS_timer matches 496 run title @a[tag=!dev] actionbar hud:fade_in_1
execute if score .timer CS_timer matches 495 run tag @a[tag=!dev] remove hide_ui

# display  planet name
execute if score .timer CS_timer matches 117 run title @a[tag=!dev] actionbar hud:planet:felucia
execute if score .timer CS_timer matches 217 run title @a[tag=!dev] actionbar hud:blackbars


## models and triggers
execute if score .timer CS_timer matches 495 run tickingarea remove tmp.cutscene.0
execute if score .timer CS_timer matches 495 run tickingarea remove tmp.cutscene.1

# shot 1
execute if score .timer CS_timer matches 21 run summon spark:skybox_static 5997.5 65 -0.5 0 0 spark:set_planet_space
execute if score .timer CS_timer matches 21 run summon spark:cutscene.eta2_to_planet 5997.5 65 -0.5 0 0 spark:stage_felucia
execute if score .timer CS_timer matches 230 run event entity @e[type=spark:cutscene.eta2_to_planet] spark:despawn
execute if score .timer CS_timer matches 230 run event entity @e[type=spark:skybox_static] spark:despawn
# shot 2
execute if score .timer CS_timer matches 200 run event entity @e[type=spark:cutscene.eta2] spark:despawn
execute if score .timer CS_timer matches 211 run summon spark:cutscene.eta2 8947.5 49 5737 180 0 spark:stage_ch08_c11_s2

execute if score .timer CS_timer matches 492 run event entity @e[type=spark:cutscene.eta2] spark:despawn
execute if score .timer CS_timer matches 495 run summon spark:cutscene.eta2 8947.5 49 5736 0 0


## camera
# shot 1
# shot 1 , reset skyboxes and summon static black one, camera command shot, set and reset cam busy for players
execute if score .timer CS_timer matches 20 run playsound sound.spark.cutscene.hyperspace_exit @a
execute if score .timer CS_timer matches 20 run tp @a[tag=!dev] 5997.5 65 -0.5 0 0
execute if score .timer CS_timer matches 21 run event entity @a[tag=!dev] spark:set_cam_used
execute if score .timer CS_timer matches 21..210 run function spark/cutscene/shots/ch02_c11_s1
execute if score .timer CS_timer matches 210 run event entity @a[tag=!dev] spark:reset_cam_used
# shot 2 -281
execute if score .timer CS_timer matches 220 run playsound sound.spark.cutscene.arrive_felucia @a
execute if score .timer CS_timer matches 215 run camera @a[tag=!dev] set minecraft:first_person 
execute if score .timer CS_timer matches 211..492 run effect @a[tag=!dev] slowness 1 4 true
execute if score .timer CS_timer matches 211..492 run function spark/cutscene/shots/ch08_c11_s2


## timer management
# reset
execute if score .timer CS_timer matches 500 run function spark/cutscene/setup
# timer
scoreboard players add .timer CS_timer 1
