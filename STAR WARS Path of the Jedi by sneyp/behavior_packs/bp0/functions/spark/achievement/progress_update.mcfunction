# © Spark Universe, 2023
# authors: FetchBot
# description: load the achievement area and spawn in the display entities
# called by: spark/achievement/trigger/*

scoreboard players add .completed SS_achievements 1
execute if score .completed SS_achievements matches 4 run function spark/achievement/enable_puzzle_level