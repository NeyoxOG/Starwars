# © Spark Universe, 2023
# authors: FetchBot
# description: modified version of tutorial/elevator/debug/summon_buttons
# called by: spark/temple_crafting_room/delayed_setup_1s

summon spark:elevator_button ^ ^3.0 ^4.2 ~180 ~ spark:council
summon spark:elevator_button ^ ^2.625 ^4.2 ~180 ~ spark:dueling
summon spark:elevator_button ^ ^2.25 ^4.2 ~180 ~ spark:crafting
summon spark:elevator_button ^ ^1.875 ^4.2 ~180 ~ spark:temple
summon spark:elevator_button ^ ^1.5 ^4.2 ~180 ~ spark:archives

execute positioned ^ ^3.0 ^4.2 run tag @e[type=spark:elevator_button,c=1] add council
execute positioned ^ ^2.625 ^4.2 run tag @e[type=spark:elevator_button,c=1] add dueling
execute positioned ^ ^2.25 ^4.2 run tag @e[type=spark:elevator_button,c=1] add crafting
execute positioned ^ ^1.875 ^4.2 run tag @e[type=spark:elevator_button,c=1] add temple
execute positioned ^ ^1.5 ^4.2 run tag @e[type=spark:elevator_button,c=1] add archives
