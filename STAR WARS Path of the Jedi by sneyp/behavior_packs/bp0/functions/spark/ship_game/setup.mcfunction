# © Spark Universe, 2023
# authors: Tristan
# description: Set up game rules, scoreboards, etc.
# called by: manually

# #Minigame
scoreboard objectives add area_fatigue dummy
scoreboard objectives add spawn_hoard dummy
scoreboard objectives add spawn_loner dummy
scoreboard objectives add ship_score dummy

scoreboard objectives add .data dummy

scoreboard objectives add ship_game dummy
scoreboard players set .state ship_game 0
scoreboard players set .game_timer ship_game 0
scoreboard players set .high_score ship_game 0