### main loop of cutscene ch02 c01 Crucible lands on ilum
# called like: execute if score .timer CS_timer matches X run X 
# duration: 640 ticks


## visibility
effect @a[tag=!dev] invisibility 1 1 true
execute if score .timer CS_timer matches 325..628 run gamemode spectator @a[tag=!dev] 
execute if score .timer CS_timer matches 20 run event entity @a[tag=!dev] spark:set_in_cutscene


## final player location
execute if score .timer CS_timer matches 630 run tp @a[tag=!dev] 142.5 -25.00 3001.5 69 0
execute if score .timer CS_timer matches 630 run camera @a[tag=!dev] fade time 0 0.6 3 color 243 243 244
execute if score .timer CS_timer matches 630 run gamemode a @a[tag=!dev]
execute if score .timer CS_timer matches 20 run function spark/cutscene/inv_clear


## sound


## UI
execute if score .timer CS_timer matches 19 run tag @a[tag=!dev] add hide_ui
# execute if score .timer CS_timer matches 0 run title @a[tag=!dev] actionbar hud:fade_out_1
execute if score .timer CS_timer matches 25 run title @a[tag=!dev] actionbar hud:blackbars_in

execute if score .timer CS_timer matches 608 run title @a[tag=!dev] actionbar hud:blackbars_out
execute if score .timer CS_timer matches 630 run title @a[tag=!dev] actionbar hud:fade_in_1
execute if score .timer CS_timer matches 629 run tag @a[tag=!dev] remove hide_ui

execute if score .timer CS_timer matches 205 run title @a[tag=!dev] actionbar hud:planet:ilum

# adjustments can be removed/added here @marcel.cutscene
execute if score .timer CS_timer matches 316 run title @a[tag=!dev] actionbar hud:blackbars_out_03
execute if score .timer CS_timer matches 332 run title @a[tag=!dev] actionbar hud:blackbars_in_03
# execute if score .timer CS_timer matches 323 run title @a[tag=!dev] actionbar hud:blackbars


## models and triggers
# ticking area
# execute if score .timer CS_timer matches 0 run tickingarea add circle 5997.5 65 -0.5 1 tmp.cutscene.0
# execute if score .timer CS_timer matches 0 run tickingarea add circle 144 -25 2998 1 tmp.cutscene.1
execute if score .timer CS_timer matches 640 run tickingarea remove tmp.cutscene.0
execute if score .timer CS_timer matches 640 run tickingarea remove tmp.cutscene.1
execute if score .timer CS_timer matches 640 run tickingarea remove tmp.cutscene.2

# shot 1 - space
execute if score .timer CS_timer matches 19 run summon spark:skybox_static 5997.5 90 -0.5 0 0 spark:set_planet_space
execute if score .timer CS_timer matches 21 run summon spark:cutscene.crucible_to_ilum 5997.5 65 -0.5 180 0 spark:stage_play
execute if score .timer CS_timer matches 330 run event entity @e[type=spark:cutscene.crucible_to_ilum] spark:despawn


# shot 2 - landing
execute if score .timer CS_timer matches 310 run summon spark:skybox_static 144 -13 2998 0 0 spark:set_planet_ilum
execute if score .timer CS_timer matches 320 run camera @a[tag=!dev] fade time 0 0 3 color 243 243 244
execute if score .timer CS_timer matches 323 run summon spark:cutscene.crucible 144 -25 2998 180 0 spark:stage_landing
execute if score .timer CS_timer matches 629 run event entity @e[type=spark:cutscene.crucible] spark:despawn

# after shot 2 - blocks
execute if score .timer CS_timer matches 629 run structure load spark:crucible_1 138 -25 2975
execute if score .timer CS_timer matches 631 run structure load spark:crucible_2 202 -25 2975
execute if score .timer CS_timer matches 630 run event entity @e[type=spark:skybox_static] spark:despawn

## camera
# shot 1: 301 ticks
execute if score .timer CS_timer matches 20 run tp @a[tag=!dev] 5997.5 67 1.5
execute if score .timer CS_timer matches 21 run event entity @a[tag=!dev] spark:set_cam_used
execute if score .timer CS_timer matches 21..322 run effect @a[tag=!dev] slowness 0 0 true
execute if score .timer CS_timer matches 21..322 run function spark/cutscene/shots/ch02_c01_s1
execute if score .timer CS_timer matches 322 run event entity @a[tag=!dev] spark:reset_cam_used

# shot 2: 305 ticks
execute if score .timer CS_timer matches 325 run camera @a[tag=!dev] set minecraft:first_person 
execute if score .timer CS_timer matches 323 run tp @a[tag=!dev] 5997.5 65 -0.5 180 0
execute if score .timer CS_timer matches 322 run effect @a[tag=!dev] slowness 0 0 true
execute if score .timer CS_timer matches 323..628 run function spark/cutscene/shots/ch02_c01_s2


## timer management
# reset
execute if score .timer CS_timer matches 640 run function spark/cutscene/setup
# timer
scoreboard players add .timer CS_timer 1