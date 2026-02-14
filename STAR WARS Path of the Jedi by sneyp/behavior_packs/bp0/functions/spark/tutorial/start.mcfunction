# © Spark Universe, 2023
# authors: Arcaniax
# description: Starts the map
# called by: button in starting room
scoreboard players set .player_count tutorial 0
execute as @a run scoreboard players add .player_count tutorial 1

# mission states
scoreboard objectives add glob_mission_state dummy
scoreboard players set .hub glob_mission_state 0

execute if score .player_count tutorial matches ..4 run function spark/tutorial/start_game
execute if score .player_count tutorial matches 5.. run titleraw @a actionbar {"rawtext":[{ "text": "hud:warning:" },{"translate":"spark.ui.tutorial.4_players", "with": [ "\n" ] }]}