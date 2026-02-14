### main loop of cutscene ch09 c02
# called like: execute if score .timer CS_timer matches X run X 
# duration: 545 ticks


## visibility
execute if score .timer CS_timer matches 20 run inputpermission set @a[tag=!dev] camera disabled
execute if score .timer CS_timer matches 20 run inputpermission set @a[tag=!dev] movement disabled
effect @a[tag=!dev,tag=!is_host] invisibility 1 1 true
execute if score .timer CS_timer matches ..322 run effect @a[tag=!dev,tag=is_host] invisibility 1 1 true

execute if score .timer CS_timer matches 20 run event entity @a[tag=!dev] spark:set_in_cutscene

execute if score .timer CS_timer matches 20 run function spark/cutscene/inv_clear
execute if score .timer CS_timer matches 454 run function spark/cutscene/inv_fill

## final player location
execute if score .timer CS_timer matches 456 run tp @a[tag=!dev] 9136.5 105 73.5 0 0


## sound
execute if score .timer CS_timer matches 10 run playsound sound.spark.cutscene.survival_ending @a
execute if score .timer CS_timer matches 20 run music stop 5.0
execute if score .timer CS_timer matches 333 run music stop 3.0

## UI
execute if score .timer CS_timer matches 20 run tag @a[tag=!dev] add hide_ui
#execute if score .timer CS_timer matches 0 run title @a[tag=!dev] actionbar hud:fade_out_1
execute if score .timer CS_timer matches 21 run title @a[tag=!dev] actionbar hud:blackbars_in


execute if score .timer CS_timer matches 285 run title @a[tag=!dev] actionbar hud:blackbars_out
execute if score .timer CS_timer matches 332 run title @a[tag=!dev] actionbar hud:blackbars_in


execute if score .timer CS_timer matches 434 run title @a[tag=!dev] actionbar hud:blackbars_out
#execute if score .timer CS_timer matches 455 run title @a[tag=!dev] actionbar hud:fade_in_1
execute if score .timer CS_timer matches 454 run tag @a[tag=!dev] remove hide_ui


## models and triggers
execute if score .timer CS_timer matches 324 run tickingarea remove tmp.cutscene.0
execute if score .timer CS_timer matches 455 run tickingarea remove tmp.cutscene.1

execute if score .timer CS_timer matches 20 run summon spark:cutscene.kamino_defeat 9026.5 95 0.5 -90 0 spark:stage_play
execute if score .timer CS_timer matches 323 run event entity @e[type=spark:cutscene.kamino_defeat] spark:despawn


## camera
# shot 1 - defeat pov
execute if score .timer CS_timer matches 20..322 run effect @a[tag=!dev] slowness 1 4 true
execute if score .timer CS_timer matches 20..322 run function spark/cutscene/shots/ch09_c02_s1


# shot 2 - floaty tanky 9136.5 108.5 83.5
execute if score .timer CS_timer matches 324 run event entity @a[tag=!dev] spark:set_cam_used
execute if score .timer CS_timer matches 324 run event entity @a[tag=!dev, tag=is_host] spark:play_cutscene_anim_ch09_c02_s2
# actually y rot should be 0 but because of minecraft it has to be 30 tho
execute if score .timer CS_timer matches 324..454 run tp @a[tag=!dev,tag=is_host] 9136.5 108 83.5 50 0
execute if score .timer CS_timer matches 324 run effect @a[tag=!dev,tag=is_host] clear
execute if score .timer CS_timer matches 454 run event entity @a[tag=!dev, tag=is_host] spark:reset_cutscene_anim

execute if score .timer CS_timer matches 324 run tp @a[tag=!dev,tag=!is_host] 9136.5 105 73.5 0 0

execute if score .timer CS_timer matches 325 positioned 9136.5 105 73.5 run tag @e[type=spark:nala_se, r=20, c=1] remove has_quest

execute if score .timer CS_timer matches 326 as @a[tag=!dev] run camera @s set minecraft:free pos 9136.5 106.22 73.32 rot -12.0 0.0
execute if score .timer CS_timer matches 333..454 run function spark/cutscene/shots/ch09_c02_s2
execute if score .timer CS_timer matches 455 run event entity @a[tag=!dev] spark:reset_cam_used


## timer management
# reset
execute if score .timer CS_timer matches 456 run function spark/cutscene/setup
# timer
scoreboard players add .timer CS_timer 1