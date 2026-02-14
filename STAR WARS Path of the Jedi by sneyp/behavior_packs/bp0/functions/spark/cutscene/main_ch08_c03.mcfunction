### main loop of cutscene ch08 c03
# called like: execute if score .timer CS_timer matches X run X 
# duration: 240 ticks


## visibility
execute if score .timer CS_timer matches 20.. run effect @a[tag=!dev] invisibility 1 1 true
effect @a[tag=!dev] slow_falling 1 254 true
execute if score .timer CS_timer matches 20 run event entity @a[tag=!dev] spark:set_in_cutscene


## final player location
execute if score .timer CS_timer matches 229 run tp @a[tag=!dev] 6049.37 53.00 5999.82 90 0
execute if score .timer CS_timer matches 229 run summon spark:sand_beast 6006.5 50.00 5999.5 -90 0 spark:boss


execute if score .timer CS_timer matches 20 run function spark/cutscene/inv_clear
execute if score .timer CS_timer matches 229 run function spark/cutscene/inv_fill


## sound
execute if score .timer CS_timer matches 20 run music stop 1.0
execute if score .timer CS_timer matches 22 run music play sound.spark.music.ZamTheAssassinTatooine 1.0 0.1 loop
execute if score .timer CS_timer matches 20 run playsound sound.spark.cutscene.sandbeast_intro @a

## UI
execute if score .timer CS_timer matches 20 run tag @a[tag=!dev] add hide_ui
# execute if score .timer CS_timer matches 0 run title @a[tag=!dev] actionbar hud:fade_out_1
execute if score .timer CS_timer matches 21 run title @a[tag=!dev] actionbar hud:blackbars_in
execute if score .timer CS_timer matches 208 run title @a[tag=!dev] actionbar hud:blackbars_out
execute if score .timer CS_timer matches 229 run title @a[tag=!dev] actionbar hud:fade_in_1
execute if score .timer CS_timer matches 228 run tag @a[tag=!dev] remove hide_ui


## models and triggers
execute if score .timer CS_timer matches 230 run tickingarea remove tmp.cutscene.0
execute if score .timer CS_timer matches 230 run tickingarea remove tmp.cutscene.1


execute if score .timer CS_timer matches 0..20 run event entity @e[type=spark:sand_beast] spark:despawn
execute if score .timer CS_timer matches 20 run summon spark:cutscene.sandbeast 6013.5 50 5999.5 180 0 spark:stage_play
execute if score .timer CS_timer matches 35 run particle spark:cutscene.dig 6013.5 50 5999.5
execute if score .timer CS_timer matches 30 run particle spark:cutscene.dust 6013.5 50.5 5999.5


execute if score .timer CS_timer matches 228 run event entity @e[type=spark:cutscene.sandbeast] spark:despawn

## camera
execute if score .timer CS_timer matches 20..228 run effect @a[tag=!dev] slowness 1 3 true
execute if score .timer CS_timer matches 20..228 run function spark/cutscene/shots/ch08_c03_s1
execute if score .timer CS_timer matches 229 run effect @a[tag=!dev] slowness 0 0 true

## timer management
# reset
execute if score .timer CS_timer matches 230 run function spark/cutscene/setup
# timer
scoreboard players add .timer CS_timer 1