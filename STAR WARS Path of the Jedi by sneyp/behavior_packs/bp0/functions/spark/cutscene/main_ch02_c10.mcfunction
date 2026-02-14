### main loop of cutscene ch02 c10 - Astromech fixes crucible
# called like: execute if score .timer CS_timer matches X run X 
# duration: 386 ticks


## visibility
execute if score .timer CS_timer matches 20.. run effect @a[tag=!dev] invisibility 1 1 true
effect @a[tag=!dev] slow_falling 1 255 true
execute if score .timer CS_timer matches 20 run event entity @a[tag=!dev] spark:set_in_cutscene



## final player location
execute if score .timer CS_timer matches 386 run tp @a[tag=!dev] 3016.78 -28.56 2987.10 -117.5 25

execute if score .timer CS_timer matches 20 run function spark/cutscene/inv_clear
execute if score .timer CS_timer matches 386 run function spark/cutscene/inv_fill


## sound
execute if score .timer CS_timer matches 20 run playsound sound.spark.cutscene.crucible_repairment @a
execute if score .timer CS_timer matches 10 run music stop 1.0
execute if score .timer CS_timer matches 15 run music play sound.spark.music.JarJarsIntroduction


## UI
execute if score .timer CS_timer matches 21 run tag @a[tag=!dev] add hide_ui
execute if score .timer CS_timer matches 385 run tag @a[tag=!dev] remove hide_ui
# execute if score .timer CS_timer matches 0 run title @a[tag=!dev] actionbar hud:fade_out_1
execute if score .timer CS_timer matches 22 run title @a[tag=!dev] actionbar hud:blackbars_in
execute if score .timer CS_timer matches 364 run title @a[tag=!dev] actionbar hud:blackbars_out
execute if score .timer CS_timer matches 386 run title @a[tag=!dev] actionbar hud:fade_in_1


## models and triggers
# load areas
# execute if score .timer CS_timer matches 0 run tickingarea add circle 2970.5 -50.5 3085.6 1 tmp.cutscene.0
# execute if score .timer CS_timer matches 0 run tickingarea add circle 3177.5 -39.5 3016.5 1 tmp.cutscene.1
execute if score .timer CS_timer matches 380 run tickingarea remove tmp.cutscene.0
execute if score .timer CS_timer matches 380 run tickingarea remove tmp.cutscene.1


# reset
execute if score .timer CS_timer matches 21 run event entity @e[type=spark:cutscene.astromech] spark:despawn
execute if score .timer CS_timer matches 121 run event entity @e[type=spark:cutscene.astromech] spark:despawn
execute if score .timer CS_timer matches 386 run event entity @e[type=spark:cutscene.astromech] spark:despawn
# set
execute if score .timer CS_timer matches 21 run summon spark:cutscene.astromech 2970.5 -50.5 3085 180 0 spark:stage_shot_1
# this one replays stage one animation
execute if score .timer CS_timer matches 124 run summon spark:cutscene.astromech 3177.5 -39.5 3016.5 90 0 spark:stage_shot_2
execute if score .timer CS_timer matches 156 run setblock 3177.62 -40.00 3016.62 spark:crucible_metal_yellow_slab

execute if score .timer CS_timer matches 200 run particle spark:astromech_work_sparks 3174.2 -38.4 3019.0
execute if score .timer CS_timer matches 220 run particle spark:astromech_work_sparks 3174.2 -38.4 3019.0
execute if score .timer CS_timer matches 235 run particle spark:astromech_work_sparks 3174.2 -38.4 3019.0
execute if score .timer CS_timer matches 245 run particle spark:astromech_work_sparks 3174.2 -38.4 3019.0
execute if score .timer CS_timer matches 265 run particle spark:astromech_work_sparks 3174.2 -38.4 3019.0
execute if score .timer CS_timer matches 310 run particle spark:astromech_work_sparks 3172.2 -38.4 3019.0
execute if score .timer CS_timer matches 325 run particle spark:astromech_work_sparks 3172.2 -38.4 3019.0
execute if score .timer CS_timer matches 335 run particle spark:astromech_work_sparks 3172.2 -38.4 3019.0
execute if score .timer CS_timer matches 350 run particle spark:astromech_work_sparks 3172.2 -38.4 3019.0



## camera
execute if score .timer CS_timer matches 20..382 run effect @a[tag=!dev] slowness 1 2 true
# init
execute if score .timer CS_timer matches 19 run tp @a[tag=!dev] 2970.5 -57.11 3080 0 -6
# shot 1: 101 t
execute if score .timer CS_timer matches 21 run tp @a[tag=!dev] 2970.5 -57.11 3080 0 -6
execute if score .timer CS_timer matches 22..122 as @a[tag=!dev] at @s run tp @a[tag=!dev] ~ ~ ~.01
# shot 2: 61 t
execute if score .timer CS_timer matches 123 run tp @a[tag=!dev] 3173.93 -39.91 3014.4 -51.2 11.3
execute if score .timer CS_timer matches 124..184 as @a[tag=!dev] at @s run tp @a[tag=!dev] ~-0.0056 ~ ~-0.0044

# shot 3: 201 t
execute if score .timer CS_timer matches 185 run tp @a[tag=!dev] 3169.2 -38.8 3012.2 -38.2 12.8
execute if score .timer CS_timer matches 186..380 as @a[tag=!dev] at @s run tp @a[tag=!dev] ~-0.0237 ~.0235 ~-0.0376 ~.017 ~.0575 
execute if score .timer CS_timer matches 381.. as @a[tag=!dev] at @s run tp @a[tag=!dev] 3047.53 -49.00 2962.95 180 0

# alter skybox to cut off floating boxes
execute if score .timer CS_timer matches 20 run event entity @a[tag=!dev] spark:skybox_set_space_mini
execute if score .timer CS_timer matches 380 run event entity @a[tag=!dev] spark:skybox_set_space


## timer management
# reset
execute if score .timer CS_timer matches 386 run function spark/cutscene/setup
# timer
scoreboard players add .timer CS_timer 1