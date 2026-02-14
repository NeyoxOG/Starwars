### main loop of cutscene ch02 c08
# called like: execute if score .timer CS_timer matches X run X 
# duration: 100 ticks


## visibility
effect @a invisibility 1 1 true
gamemode spectator @a
execute if score .timer CS_timer matches 20 run event entity @a[tag=!dev] spark:set_in_cutscene




## final player location


## sound


## UI
execute if score .timer CS_timer matches 0 run title @a actionbar hud:fade_out_1
execute if score .timer CS_timer matches 20 run title @a actionbar hud:fade_in_1
execute if score .timer CS_timer matches 80 run title @a actionbar hud:fade_out_1
execute if score .timer CS_timer matches 100 run title @a actionbar hud:fade_in_1


## models and triggers


## camera


## timer management
# reset
execute if score .timer CS_timer matches 100 run function spark/cutscene/setup
# timer
scoreboard players add .timer CS_timer 1