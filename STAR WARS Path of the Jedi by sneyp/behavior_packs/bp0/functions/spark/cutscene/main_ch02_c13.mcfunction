### main loop of cutscene ch02 c12
# called like: execute if score .timer CS_timer matches X run X 
# duration: 100 ticks

# --- Jedi Temple Main Hall Intro ---

## visibility
execute if score .timer CS_timer matches 20.. run effect @a[tag=!dev] invisibility 1 1 true
execute if score .timer CS_timer matches 20 run event entity @a[tag=!dev] spark:set_in_cutscene
execute if score .timer CS_timer matches 20.. run effect @a[tag=!dev] slowness 1 3 true
execute if score .timer CS_timer matches 20.. run gamemode spectator @a[tag=!dev]



execute if score .timer CS_timer matches 20 run function spark/cutscene/inv_clear
execute if score .timer CS_timer matches 544 run function spark/cutscene/inv_fill





## final player location
execute if score .timer CS_timer matches 543 run tp @a[tag=!dev] 3270.5 51 0.5 -90 0

## sound
execute if score .timer CS_timer matches 16 run playsound sound.spark.cutscene.coruscant_showcase @a

## UI
execute if score .timer CS_timer matches 19 run titleraw @a[tag=!dev] title {"rawtext":[{ "text": "hud:elevator:" }]}
execute if score .timer CS_timer matches 20 run tag @a[tag=!dev] add hide_ui
#execute if score .timer CS_timer matches 0 run title @a[tag=!dev] actionbar hud:fade_out_1
execute if score .timer CS_timer matches 21 run title @a[tag=!dev] actionbar hud:blackbars_in
execute if score .timer CS_timer matches 22 run titleraw @a[tag=!dev] title {"rawtext":[{ "text": "hud:elevator:" }]}
execute if score .timer CS_timer matches 522 run titleraw @a[tag=!dev] title {"rawtext":[{ "text": "hud:elevator:" }]}

execute if score .timer CS_timer matches 522 run title @a[tag=!dev] actionbar hud:blackbars_out
execute if score .timer CS_timer matches 545 run title @a[tag=!dev] actionbar hud:fade_in
execute if score .timer CS_timer matches 543 as @a[tag=!dev] run function spark/tutorial/elevator/temple
execute if score .timer CS_timer matches 543 as @a[tag=!dev] at @s run playsound sound.spark.cutscene_elevator @s
execute if score .timer CS_timer matches 543 as @a[tag=!dev] run tag @a remove elevator_tp
execute if score .timer CS_timer matches 543 as @a[tag=!dev] run tag @a remove elevator_tmp
execute if score .timer CS_timer matches 542 run tag @a[tag=!dev] remove hide_ui
execute if score .timer CS_timer matches 542 run effect @a[tag=!dev] slowness 0

## camera
execute if score .timer CS_timer matches 21..542 run function spark/cutscene/shots/ch02_c13_s1

## timer management
# reset
execute if score .timer CS_timer matches 544 run title @a[tag=!dev] title hud:elevator:
execute if score .timer CS_timer matches 544 run tag @a remove REMOVE_ELEVATOR_TAG
execute if score .timer CS_timer matches 545 run function spark/cutscene/setup
# timer
scoreboard players add .timer CS_timer 1