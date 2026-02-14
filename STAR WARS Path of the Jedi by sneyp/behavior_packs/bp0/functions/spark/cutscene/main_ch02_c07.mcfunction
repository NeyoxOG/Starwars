### main loop of cutscene ch02 c07
# called like: execute if score .timer CS_timer matches X run X 
# duration: 326 ticks


## sound
execute if score .timer CS_timer matches 1 run music stop 0.1
execute if score .timer CS_timer matches 2 run music play sound.spark.music.YodaAndTheYounglingsA
execute if score .timer CS_timer matches 1 run playsound sound.spark.cutscene.huyang_reveal @a


## UI
execute if score .timer CS_timer matches 19 run tag @a[tag=!dev] add hide_ui
# execute if score .timer CS_timer matches 0 run title @a[tag=!dev] actionbar hud:fade_out_1
execute if score .timer CS_timer matches 21 run title @a[tag=!dev] actionbar hud:blackbars_in

execute if score .timer CS_timer matches 300 run title @a[tag=!dev] actionbar hud:blackbars_out
execute if score .timer CS_timer matches 325 run title @a[tag=!dev] actionbar hud:fade_in_1
execute if score .timer CS_timer matches 321 run tag @a[tag=!dev] remove hide_ui


## models and triggers
# player
execute if score .timer CS_timer matches 11 run tp @a[tag=!dev] 3029.5 -56 3033.5
execute if score .timer CS_timer matches 13 as @a[tag=!dev] at @s run spreadplayers ~ ~ 0 3 @s
execute if score .timer CS_timer matches 15 as @a[tag=!dev] at @s run tp ~ -56 ~ facing 3019.5 -56 3033.5
# loading
execute if score .timer CS_timer matches 325 run tickingarea remove tmp.cutscene.0
# models
execute if score .timer CS_timer matches 120 run event entity @e[type=spark:huyang_counter] spark:hide
execute if score .timer CS_timer matches 20 run summon spark:cutscene.huyang 3019.5 -56 3035.5 180 0 spark:stage_play
execute if score .timer CS_timer matches 323 run event entity @e[type=spark:cutscene.huyang] spark:despawn
execute if score .timer CS_timer matches 323 run event entity @e[type=spark:huyang_counter] spark:show

# teleport 
execute if score .timer CS_timer matches 323 run tp @e[c=1,type=spark:master_huyang] 3019.44 -56.00 3033.48


## camera only - 241 t
execute if score .timer CS_timer matches 20 run event entity @a[tag=!dev] spark:set_cam_used
execute if score .timer CS_timer matches 20..321 run function spark/cutscene/shots/ch02_c07_s1
execute if score .timer CS_timer matches 322 run event entity @a[tag=!dev] spark:reset_cam_used


## timer management
# reset
execute if score .timer CS_timer matches 326 run function spark/cutscene/setup
# timer
scoreboard players add .timer CS_timer 1