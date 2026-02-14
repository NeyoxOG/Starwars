### main loop of cutscene ch08 c13
# called like: execute if score .timer CS_timer matches X run X 
# duration: 125 ticks


## visibility
execute if score .timer CS_timer matches 20.. run effect @a[tag=!dev] invisibility 1 1 true
effect @a[tag=!dev] slow_falling 1 254 true
execute if score .timer CS_timer matches 20 run event entity @a[tag=!dev] spark:set_in_cutscene


## final player location
execute if score .timer CS_timer matches 124 run tp @a[tag=!dev] 8860.20 55.00 6118.63 90 -2.25
execute if score .timer CS_timer matches 124 run summon spark:acklay 8823 55 6120 -90 0 spark:boss


execute if score .timer CS_timer matches 20 run function spark/cutscene/inv_clear
execute if score .timer CS_timer matches 124 run function spark/cutscene/inv_fill


## sound
execute if score .timer CS_timer matches 18 run music stop 1.0
execute if score .timer CS_timer matches 20 run music play sound.spark.music.ZamTheAssassinFelucia 1.0 0.1 loop

## UI
execute if score .timer CS_timer matches 20 run tag @a[tag=!dev] add hide_ui
# execute if score .timer CS_timer matches 0 run title @a[tag=!dev] actionbar hud:fade_out_1
execute if score .timer CS_timer matches 21 run title @a[tag=!dev] actionbar hud:blackbars_in
execute if score .timer CS_timer matches 102 run title @a[tag=!dev] actionbar hud:blackbars_out
execute if score .timer CS_timer matches 123 run title @a[tag=!dev] actionbar hud:fade_in_1
execute if score .timer CS_timer matches 122 run tag @a[tag=!dev] remove hide_ui


## models and triggers
execute if score .timer CS_timer matches 143 run tickingarea remove tmp.cutscene.0
execute if score .timer CS_timer matches 143 run tickingarea remove tmp.cutscene.1


execute if score .timer CS_timer matches 0..20 run event entity @e[type=spark:acklay] spark:despawn
execute if score .timer CS_timer matches 20 run summon spark:cutscene.acklay 8828.5 55 6121.5 180 0 spark:stage_play
execute if score .timer CS_timer matches 122 run event entity @e[type=spark:cutscene.acklay] spark:despawn

## camera
execute if score .timer CS_timer matches 20..121 run effect @a[tag=!dev] slowness 1 3 true
execute if score .timer CS_timer matches 20..121 run function spark/cutscene/shots/ch08_c13_s1
execute if score .timer CS_timer matches 122 run effect @a[tag=!dev] slowness 0 0 true

## timer management
# reset
execute if score .timer CS_timer matches 125 run function spark/cutscene/setup
# timer
scoreboard players add .timer CS_timer 1