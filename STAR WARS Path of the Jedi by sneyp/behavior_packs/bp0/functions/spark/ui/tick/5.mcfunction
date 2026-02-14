# © Spark Universe, 2023
# authors: William Savage, FetchBot
# description: UI loop, runs once a second by each player
# called by: ui/loop

execute if score @s SS_ui_robe_hover matches 0 run title @s subtitle hud:robe:
execute if score @s SS_ui_robe_hover matches 0 run title @s title hud:robe:

execute if score @s SS_ui_robe_hover matches 1 run titleraw @s title {"rawtext":[{"text":"hud:robe:"},{"translate":"spark.ui.robe.default.name","with":["\n"]},{"text":"\n"},{"translate":"spark.ui.robe.default.requirement","with":["\n"]}]}
execute if score @s SS_ui_robe_hover matches 2 run titleraw @s subtitle {"rawtext":[{"text":"hud:robe:"},{"translate":"spark.ui.robe.dueling.status","with":{"rawtext":[{"score":{"name":".global","objective":"dueling_rank"}}]}}]}
execute if score @s SS_ui_robe_hover matches 2 run titleraw @s title {"rawtext":[{"text":"hud:robe:"},{"translate":"spark.ui.robe.dueling.name","with":["\n"]},{"text":"\n"},{"translate":"spark.ui.robe.dueling.requirement","with":["\n"]}]}
execute if score @s SS_ui_robe_hover matches 3 run titleraw @s subtitle {"rawtext":[{"text":"hud:robe:"},{"translate":"spark.ui.robe.battleship.status","with":{"rawtext":[{"score":{"name":"kamino","objective":"wins"}}]}}]}
execute if score @s SS_ui_robe_hover matches 3 run titleraw @s title {"rawtext":[{"text":"hud:robe:"},{"translate":"spark.ui.robe.battleship.name","with":["\n"]},{"text":"\n"},{"translate":"spark.ui.robe.battleship.requirement","with":["\n"]}]}
execute if score @s SS_ui_robe_hover matches 4 run titleraw @s subtitle {"rawtext":[{"text":"hud:robe:"},{"translate":"spark.ui.robe.monster.status","with":{"rawtext":[{"score":{"name":"kamino","objective":"wins"}}]}}]}
execute if score @s SS_ui_robe_hover matches 4 run titleraw @s title {"rawtext":[{"text":"hud:robe:"},{"translate":"spark.ui.robe.monster.name","with":["\n"]},{"text":"\n"},{"translate":"spark.ui.robe.monster.requirement","with":["\n"]}]}
execute if score @s SS_ui_robe_hover matches 5 run titleraw @s subtitle {"rawtext":[{"text":"hud:robe:"},{"translate":"spark.ui.robe.kamino.status","with":{"rawtext":[{"score":{"name":".highest_kills","objective":"droid_survival"}}]}}]}
execute if score @s SS_ui_robe_hover matches 5 run titleraw @s title {"rawtext":[{"text":"hud:robe:"},{"translate":"spark.ui.robe.kamino.name","with":["\n"]},{"text":"\n"},{"translate":"spark.ui.robe.kamino.requirement","with":["\n"]}]}
execute if score @s SS_ui_robe_hover matches 6 run titleraw @s title {"rawtext":[{"text":"hud:robe:"},{"translate":"spark.ui.robe.puzzles.name","with":["\n"]},{"text":"\n"},{"translate":"spark.ui.robe.puzzles.requirement","with":["\n"]}]}