# © Spark Universe, 2023
# authors: Jannis
# description: set up the lobby room for the dueling minigame
# called by: spark/dueling/setup
# executor: -

execute positioned 9000.5 22.00 9005.5 rotated 0 0 run function spark/temple_crafting_rooms/summon_buttons
summon spark:duel_leaderboard 9008.50 23.00 8992.50
execute as @e[type=spark:duel_leaderboard] run function spark/dueling/update_leaderboard

tickingarea remove dueling_lobby_temp