### main loop of cutscene ch02 c06 crucible leaves ilum
# called like: execute if score .timer CS_timer matches X run X 
# duration: 247 ticks


## visibility
execute if score .timer CS_timer matches 20.. run effect @a[tag=!dev] invisibility 1 1 true
execute if score .timer CS_timer matches 20 run event entity @a[tag=!dev] spark:set_in_cutscene

execute if score .timer CS_timer matches 20 run function spark/cutscene/inv_clear
execute if score .timer CS_timer matches 244 run replaceitem entity @a[tag=!dev] slot.hotbar 1 spark:push 1 0 {"item_lock": { "mode": "lock_in_slot" }}
execute if score .timer CS_timer matches 244 run replaceitem entity @a[tag=!dev] slot.hotbar 2 spark:grab 1 0 {"item_lock": { "mode": "lock_in_slot" }}
execute if score .timer CS_timer matches 244 run replaceitem entity @a[tag=!dev] slot.hotbar 3 spark:pull 1 0 {"item_lock": { "mode": "lock_in_slot" }}


## final player location
execute if score .timer CS_timer matches 246 run tp @a[tag=!dev] 3047 -56 2988 0 0


## sound


## UI
execute if score .timer CS_timer matches 20 run tag @a[tag=!dev] add hide_ui
# execute if score .timer CS_timer matches 0 run title @a[tag=!dev] actionbar hud:fade_out_1
execute if score .timer CS_timer matches 20 run title @a[tag=!dev] actionbar hud:blackbars_in

execute if score .timer CS_timer matches 224 run title @a[tag=!dev] actionbar hud:blackbars_out
execute if score .timer CS_timer matches 245 run title @a[tag=!dev] actionbar hud:fade_in_1
execute if score .timer CS_timer matches 244 run tag @a[tag=!dev] remove hide_ui


## models and triggers
execute if score .timer CS_timer matches 245 run tickingarea remove tmp.cutscene.1

# shot 1
execute if score .timer CS_timer matches 20 run summon spark:skybox_static 5997.5 65 -0.5 0 0 spark:set_planet_space
execute if score .timer CS_timer matches 21 run summon spark:cutscene.crucible_leaves_ilum 5997.5 65 -0.5 0 0 spark:stage_shot_1
execute if score .timer CS_timer matches 119 run event entity @e[type=spark:cutscene.crucible_leaves_ilum] spark:despawn

# shot 2
execute if score .timer CS_timer matches 122 run summon spark:cutscene.crucible_leaves_ilum 5997.5 65.5 -9 0 0 spark:stage_shot_2
execute if score .timer CS_timer matches 244 run event entity @e[type=spark:cutscene.crucible_leaves_ilum] spark:despawn

execute if score .timer CS_timer matches 244 run event entity @e[type=spark:skybox_static] spark:despawn


## camera
# shot 1 : 1 - 122
execute if score .timer CS_timer matches 20..121 run function spark/cutscene/shots/ch02_c06_s1
# shot 2 : 123 - 244
execute if score .timer CS_timer matches 122..243 run function spark/cutscene/shots/ch02_c06_s2



## timer management
# reset
execute if score .timer CS_timer matches 247 run function spark/cutscene/setup
# timer
scoreboard players add .timer CS_timer 1