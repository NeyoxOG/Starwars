# © Spark Universe, 2023
# authors: FetchBot
# description: unlocks a cloak
# called by: spark/achievement/update

event entity @s spark:unlock
event entity @s spark:is_achieved
tag @s[tag=!Pilot] add has_quest
tag @s add tall