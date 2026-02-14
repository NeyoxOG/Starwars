### main loop of cutscene ch07 c05
# called like: execute if score .timer CS_timer matches X run X 
# duration: 162 ticks


## visibility
execute if score .timer CS_timer matches 20.. run effect @a[tag=!dev] invisibility 1 1 true
effect @a[tag=!dev] slow_falling 1 254 true
execute if score .timer CS_timer matches 20 run event entity @a[tag=!dev] spark:set_in_cutscene




## final player location
execute if score .timer CS_timer matches 163 run tp @a[tag=!dev] 6056.5 -51 3115.5

execute if score .timer CS_timer matches 20 run function spark/cutscene/inv_clear
execute if score .timer CS_timer matches 161 run function spark/cutscene/inv_fill


## sound
execute if score .timer CS_timer matches 15 run playsound sound.spark.cutscene.grievous_intro @a

## UI
execute if score .timer CS_timer matches 20 run tag @a[tag=!dev] add hide_ui
execute if score .timer CS_timer matches 160 run tag @a[tag=!dev] remove hide_ui
# execute if score .timer CS_timer matches 0 run title @a[tag=!dev] actionbar hud:fade_out_1
execute if score .timer CS_timer matches 21 run title @a[tag=!dev] actionbar hud:blackbars_in
execute if score .timer CS_timer matches 140 run title @a[tag=!dev] actionbar hud:blackbars_out
execute if score .timer CS_timer matches 161 run title @a[tag=!dev] actionbar hud:fade_in_1



## models and triggers
# execute if score .timer CS_timer matches 0 run tickingarea add circle 6036.5 -53 3115.5 1 tmp.cutscene.0
execute if score .timer CS_timer matches 160 run tickingarea remove tmp.cutscene.0



execute if score .timer CS_timer matches 20 run event entity @e[type=spark:cutscene.grievous] spark:despawn
execute if score .timer CS_timer matches 21 run summon spark:cutscene.grievous 6036.5 -53 3115.5 -90 0 spark:stage_play
execute if score .timer CS_timer matches 162 run event entity @e[type=spark:cutscene.grievous] spark:despawn

## camera
execute if score .timer CS_timer matches 20 run tp @a[tag=!dev] 6056.5 -53 3115.5
# shot 01
execute if score .timer CS_timer matches 21..162 run effect @a[tag=!dev] slowness 1 2 true
execute if score .timer CS_timer matches 20 run scoreboard players set .timer_shot CS_timer 0
execute if score .timer CS_timer matches 21..162 run function spark/cutscene/shots/ch07_c05_s1


## timer management
# reset
execute if score .timer CS_timer matches 163 run function spark/cutscene/setup
# timer
scoreboard players add .timer CS_timer 1