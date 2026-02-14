### main loop of cutscene ch07 c06 - escape the hangar
# called like: execute if score .timer CS_timer matches X run X 
# duration: 320 ticks


## visibility
execute if score .timer CS_timer matches 20..309 run effect @a[tag=!dev] invisibility 1 1 true
execute if score .timer CS_timer matches 310 run effect @a[tag=!dev] clear
execute if score .timer CS_timer matches 20 run event entity @a[tag=!dev] spark:set_in_cutscene



execute if score .timer CS_timer matches 20 run function spark/cutscene/inv_clear
execute if score .timer CS_timer matches 310 run function spark/cutscene/inv_fill

## final player location

execute if score .timer CS_timer matches 310 run effect @a instant_health 1 10 true

## sound
execute if score .timer CS_timer matches 10 run playsound sound.spark.cutscene.grievous_outro @a


## UI
execute if score .timer CS_timer matches 20 run tag @a[tag=!dev] add hide_ui
# execute if score .timer CS_timer matches 0 run title @a[tag=!dev] actionbar hud:fade_out_1
execute if score .timer CS_timer matches 21 run title @a[tag=!dev] actionbar hud:blackbars_in

execute if score .timer CS_timer matches 290 run title @a[tag=!dev] actionbar hud:blackbars_out
# execute if score .timer CS_timer matches 311 run title @a[tag=!dev] actionbar hud:fade_in_1
execute if score .timer CS_timer matches 310 run tag @a[tag=!dev] remove hide_ui


## models and triggers
# execute if score .timer CS_timer matches 0 run tickingarea add circle 6069 -53 3113 1 tmp.cutscene.0
execute if score .timer CS_timer matches 320 run tickingarea remove tmp.cutscene.0


execute if score .timer CS_timer matches 10 run event entity @e[type=spark:cutscene.hangar_leave] spark:despawn
execute if score .timer CS_timer matches 21 run summon spark:cutscene.hangar_leave 6069 -53 3113 180 0 spark:stage_play
execute if score .timer CS_timer matches 312 run event entity @e[type=spark:cutscene.hangar_leave] spark:despawn

## camera
execute if score .timer CS_timer matches 19..309 run effect @a[tag=!dev] slowness 1 3 true
execute if score .timer CS_timer matches 20..310 run function spark/cutscene/shots/ch07_c06_s1
execute if score .timer CS_timer matches 310 run effect @a[tag=!dev] slowness 0 0 true

## timer management
# reset
execute if score .timer CS_timer matches 320 run function spark/cutscene/setup
# timer
scoreboard players add .timer CS_timer 1