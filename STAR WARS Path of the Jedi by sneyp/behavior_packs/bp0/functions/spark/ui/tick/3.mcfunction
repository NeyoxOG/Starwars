# © Spark Universe, 2023
# authors: Arcaniax
# description: UI loop, runs once a second by each player
# called by: ui/loop

# INFO
# UNUSED
# UNUSED
# UNUSED
# UNUSED
# UNUSED
# UNUSED

execute if score @s SS_ui_last_i matches 0 run title @s title hud:info:
execute if score @s SS_ui_last_i matches 1 run titleraw @s title {"rawtext":[{ "text": "hud:info:" },{"translate":"spark.info.1", "with": [ "\n" ] }]}
execute if score @s SS_ui_last_i matches 2 run titleraw @s title {"rawtext":[{ "text": "hud:info:" },{"translate":"spark.info.2", "with": [ "\n" ] }]}
execute if score @s SS_ui_last_i matches 3 run titleraw @s title {"rawtext":[{ "text": "hud:info:" },{"translate":"spark.info.3", "with": [ "\n" ] }]}
execute if score @s SS_ui_last_i matches 4 run titleraw @s title {"rawtext":[{ "text": "hud:info:" },{"translate":"spark.info.4", "with": [ "\n" ] }]}
execute if score @s SS_ui_last_i matches 5 run titleraw @s title {"rawtext":[{ "text": "hud:info:" },{"translate":"spark.info.5", "with": [ "\n" ] }]}
execute if score @s SS_ui_last_i matches 6 run titleraw @s title {"rawtext":[{ "text": "hud:info:" },{"translate":"spark.info.6", "with": [ "\n" ] }]}
execute if score @s SS_ui_last_i matches 7 run titleraw @s title {"rawtext":[{ "text": "hud:info:" },{"translate":"spark.info.7", "with": [ "\n" ] }]}
execute if score @s SS_ui_last_i matches 8 run titleraw @s title {"rawtext":[{ "text": "hud:info:" },{"translate":"spark.info.8", "with": [ "\n" ] }]}
execute if score @s SS_ui_last_i matches 9 run titleraw @s title {"rawtext":[{ "text": "hud:info:" },{"translate":"spark.info.9", "with": [ "\n" ] }]}