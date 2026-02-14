# © Spark Universe, 2023
# authors: Arcaniax
# description: UI loop, runs once a second by each player
# called by: ui/loop

# TASK
execute if score @s SS_ui_task matches 0 run title @s subtitle hud:task:
execute if score @s SS_ui_task matches 0 run title @s title hud:task:

execute if score @s SS_ui_task matches 1 run titleraw @s title {"rawtext":[{ "text": "hud:task:" },{"translate":"spark.task.1", "with": [ "\n" ] }]}
execute if score @s SS_ui_task matches 2 run titleraw @s title {"rawtext":[{ "text": "hud:task:" },{"translate":"spark.task.2", "with": [ "\n" ] }]}
execute if score @s SS_ui_task matches 3 run titleraw @s title {"rawtext":[{ "text": "hud:task:" },{"translate":"intro.craft_lightsaber.task.craft.task1", "with": [ "\n" ] }]}
execute if score @s SS_ui_task matches 4 run titleraw @s title {"rawtext":[{ "text": "hud:task:" },{"translate":"intro.craft_lightsaber.task.lightsaber_test.task1", "with": [ "\n" ] }]}

# multi input task for bot kills
execute if score @s SS_ui_task matches 5 run titleraw @s subtitle {"rawtext":[{ "text": "hud:task:§x" },{"score":{"name": "@s", "objective": "tut_i_bots"}},{"text": "§f/3"} ]}
execute if score @s SS_ui_task matches 5 run titleraw @s title {"rawtext":[{ "text": "hud:task:" },{"translate":"intro.training_room.task.destroy_3_remotes.task1", "with": [ "\n" ] }]}

# multi input task for bot deflects
execute if score @s SS_ui_task matches 6 run titleraw @s subtitle {"rawtext":[{ "text": "hud:task:§x" },{"score":{"name": "@s", "objective": "tut_i_deflect"}},{"text": "§f/5"} ]}
execute if score @s SS_ui_task matches 6 run titleraw @s title {"rawtext":[{ "text": "hud:task:" },{"translate":"intro.training_room.task.deflect_5_shots.task1", "with": [ "\n" ] }]}

# multi input task for bot force powers
execute if score @s SS_ui_task matches 7 run titleraw @s subtitle {"rawtext":[{ "text": "hud:task:§x" },{"score":{"name": "@s", "objective": "tut_i_bots"}},{"text": "§f/3"} ]}
execute if score @s SS_ui_task matches 7 run titleraw @s title {"rawtext":[{ "text": "hud:task:" },{"translate":"intro.training_room.task.use_force_powers.task1", "with": [ "\n" ] }]}


execute if score @s SS_ui_task matches 8 run titleraw @s title {"rawtext":[{ "text": "hud:task:" },{"translate":"intro.droid_crafting.task.build_astromech.task1", "with": [ "\n" ] }]}
execute if score @s SS_ui_task matches 9 run titleraw @s title {"rawtext":[{ "text": "hud:task:" },{"translate":"droid_survival.kamino_exterior.announcement.defeat_droids", "with": [ "\n" ] }]}

#droid survival
#execute if score @s SS_ui_task matches 10 run titleraw @s title {"rawtext":[{ "text": "hud:task:" },{"translate":"droid_survival.kamino_exterior.announcement.defeat_droids", "with": [ "\n" ] }]}

#dueling
execute if score @s SS_ui_task matches 20 run titleraw @s title {"rawtext":[{ "text": "hud:task:" },{"translate":"lightsaber_dueling.task.defeat_enemies.task1", "with": [ "\n" ] }]}
execute if score @s SS_ui_task matches 21 run titleraw @s title {"rawtext":[{ "text": "hud:task:" },{"translate":"lightsaber_dueling.task.defeat_enemies.task2", "with": [ "\n" ] }]}

#monster battle
execute if score @s SS_ui_task matches 30 run titleraw @s title {"rawtext":[{ "text": "hud:task:" },{"translate":"arena.task.take_care_of_monster.task1", "with": [ "\n" ] }]}


# tasks for escape level (5000)
# Find your ship and escape 5001
# hold off gervious 5002
# board ship 5003
execute if score @s SS_ui_task matches 5001 run titleraw @s title {"rawtext":[{ "text": "hud:task:" },{"translate":"battleship.dreadnought.task.escape.task1", "with": [ "\n" ] }]}

execute if score @s SS_ui_task matches 5002 run titleraw @s subtitle {"rawtext":[{ "text": "hud:task:§x" },{"score":{"name": ".bminute", "objective": "lv_escape_level"}},{"text": ":"},{"score":{"name": ".bsecond", "objective": "lv_escape_level"}} ]}
execute if score @s SS_ui_task matches 5002 run titleraw @s title {"rawtext":[{ "text": "hud:task:" },{"translate":"battleship.dreadnaught.take.hold_off.task1", "with": [ "\n","\n" ] }]}

execute if score @s SS_ui_task matches 5003 run titleraw @s title {"rawtext":[{ "text": "hud:task:" },{"translate":"battleship.dreadnought.task.get_to_ship.task1", "with": [ "\n" ] }]}

# puzzle level
# Help Yoda solve all the mysteries 6001
execute if score @s SS_ui_task matches 6001 run titleraw @s title {"rawtext":[{ "text": "hud:task:" },{"translate":"puzzle.planet_2.task.help_yoda.task1", "with": [ "\n" ] }]}
