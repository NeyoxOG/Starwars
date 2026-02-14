# © Spark Universe, 2023
# authors: Jannis
# description: Reset the game, move the player to the start location, and make the map ready to publish
# called by: manually


# function spark/setup

tp @a -0.50 0.00 3.5 180 0
# structure load spark:black_box -8 -1 -8

scoreboard players set .state tutorial 0
scoreboard players set .substate tutorial 0
scoreboard players set .timer tutorial 0

scoreboard players set @a SS_ui_tutorial 0
scoreboard players set @a SS_ui_task 0

tag @s remove lightsaber_unlocked
event entity @s reset_lightsaber
clear @s
gamemode adventure @s