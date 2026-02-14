### main loop of cutscene ch10 c01  - flying to torren
# called like: execute if score .timer CS_timer matches X run X 
# duration: 476 ticks


## visibility
execute if score .timer CS_timer matches 20.. run effect @a[tag=!dev] invisibility 1 1 true
execute if score .timer CS_timer matches 20 run event entity @a[tag=!dev] spark:set_in_cutscene

execute if score .timer CS_timer matches 20 run function spark/cutscene/inv_clear
execute if score .timer CS_timer matches 476 run function spark/cutscene/inv_fill

## final player location
execute if score .timer CS_timer matches 476 run tp @a[tag=!dev] 6003.08 61.00 9004.12 facing 6004.5 59.50 9001.5


## sound

## UI
execute if score .timer CS_timer matches 20 run tag @a[tag=!dev] add hide_ui
execute if score .timer CS_timer matches 21 run title @a[tag=!dev] actionbar hud:blackbars_in

execute if score .timer CS_timer matches 454 run title @a[tag=!dev] actionbar hud:blackbars_out
execute if score .timer CS_timer matches 476 run title @a[tag=!dev] actionbar hud:fade_in_1
execute if score .timer CS_timer matches 475 run tag @a[tag=!dev] remove hide_ui

# display  planet name
execute if score .timer CS_timer matches 117 run title @a[tag=!dev] actionbar hud:planet:torren
execute if score .timer CS_timer matches 217 run title @a[tag=!dev] actionbar hud:blackbars


## models and triggers
execute if score .timer CS_timer matches 476 run tickingarea remove tmp.cutscene.0
execute if score .timer CS_timer matches 476 run tickingarea remove tmp.cutscene.1

# shot 1
execute if score .timer CS_timer matches 21 run summon spark:skybox_static 5997.5 65 -0.5 0 0 spark:set_planet_space
execute if score .timer CS_timer matches 21 run summon spark:cutscene.eta2_to_planet 5997.5 65 -0.5 0 0 spark:stage_torren
execute if score .timer CS_timer matches 230 run event entity @e[type=spark:cutscene.eta2_to_planet] spark:despawn
execute if score .timer CS_timer matches 230 run event entity @e[type=spark:skybox_static] spark:despawn
# shot 2
execute if score .timer CS_timer matches 200 run event entity @e[type=spark:cutscene.eta2] spark:despawn
execute if score .timer CS_timer matches 211 run summon spark:cutscene.eta2 5997.5 62 8999.5 90 0 spark:stage_ch10_c01_s2

execute if score .timer CS_timer matches 474 run event entity @e[type=spark:cutscene.eta2] spark:despawn
execute if score .timer CS_timer matches 475 run summon spark:cutscene.eta2 5997.5 62 8999.5 0 0


## camera
# shot 1
# shot 1 , reset skyboxes and summon static black one, camera command shot, set and reset cam busy for players
execute if score .timer CS_timer matches 20 run playsound sound.spark.cutscene.hyperspace_exit @a
execute if score .timer CS_timer matches 0 run tp @a[tag=!dev] 5997.5 65 -0.5 0 0
execute if score .timer CS_timer matches 21 run event entity @a[tag=!dev] spark:set_cam_used
execute if score .timer CS_timer matches 21..210 run function spark/cutscene/shots/ch02_c11_s1
execute if score .timer CS_timer matches 21..40 run scoreboard players set @a SS_ui_tutorial 0
execute if score .timer CS_timer matches 210 run event entity @a[tag=!dev] spark:reset_cam_used
# shot 2 - 261 t
execute if score .timer CS_timer matches 220 run playsound sound.spark.cutscene.arrive_torren @a
execute if score .timer CS_timer matches 215..300 run setblock 5970.926021458485 81.09760429065216 8982.076864511599 air
execute if score .timer CS_timer matches 215..300 run setblock 5971.902476034664 80.5902844988108 8982.704871108455 air
execute if score .timer CS_timer matches 215..300 run setblock 5972.9667773473575 80.01554388468838 8983.369713876302 air
execute if score .timer CS_timer matches 215..300 run setblock 5974.943948014569 79.03288019370885 8984.56373153723 air
execute if score .timer CS_timer matches 215..300 run setblock 5974.550840984392 79.1869676236733 8984.319786507573 air
execute if score .timer CS_timer matches 215..300 run setblock 5973.809031314147 79.56341177244906 8983.879907089886 air
execute if score .timer CS_timer matches 215..300 run setblock 5970.926021458485 79.09760429065216 8982.076864511599 air
execute if score .timer CS_timer matches 215..300 run setblock 5970.926021458485 80.09760429065216 8982.076864511599 air
execute if score .timer CS_timer matches 215..300 run setblock 5971.902476034664 78.5902844988108 8982.704871108455 air
execute if score .timer CS_timer matches 215..300 run setblock 5971.902476034664 79.5902844988108 8982.704871108455 air
execute if score .timer CS_timer matches 215..300 run setblock 5972.9667773473575 78.01554388468838 8983.369713876302 air
execute if score .timer CS_timer matches 215..300 run setblock 5972.9667773473575 79.01554388468838 8983.369713876302 air
execute if score .timer CS_timer matches 215..300 run setblock 5974.943948014569 77.03288019370885 8984.56373153723 air
execute if score .timer CS_timer matches 215..300 run setblock 5974.943948014569 78.03288019370885 8984.56373153723 air
execute if score .timer CS_timer matches 215..300 run setblock 5974.550840984392 77.1869676236733 8984.319786507573 air
execute if score .timer CS_timer matches 215..300 run setblock 5974.550840984392 78.1869676236733 8984.319786507573 air
execute if score .timer CS_timer matches 215..300 run setblock 5973.809031314147 77.56341177244906 8983.879907089886 air
execute if score .timer CS_timer matches 215..300 run setblock 5973.809031314147 78.56341177244906 8983.879907089886 air
execute if score .timer CS_timer matches 215..300 run camera @a[tag=!dev] set minecraft:first_person 
execute if score .timer CS_timer matches 211..472 run effect @a[tag=!dev] slowness 1 4 true
execute if score .timer CS_timer matches 211..472 run function spark/cutscene/shots/ch10_c01_s2
execute if score .timer CS_timer matches 460 run scoreboard players set @a SS_ui_tutorial 0
execute if score .timer CS_timer matches 460 run music stop 2.0


## timer management
# reset
execute if score .timer CS_timer matches 476 run function spark/cutscene/setup
# timer
scoreboard players add .timer CS_timer 1
