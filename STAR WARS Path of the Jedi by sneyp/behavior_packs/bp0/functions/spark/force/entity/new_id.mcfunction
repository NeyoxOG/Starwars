# © Spark Universe, 2023
# authors: ChainsawNinja
# description: assigns new ID to non-player object
# called by: (variety)

#
scoreboard players add .ID.object .data 1
scoreboard players operation @s ID.object = .ID.object .data
