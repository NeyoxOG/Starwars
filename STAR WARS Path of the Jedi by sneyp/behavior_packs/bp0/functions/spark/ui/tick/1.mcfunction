# © Spark Universe, 2023
# authors: Arcaniax
# description: UI loop, runs once a second by each player
# called by: ui/loop

# TUTORIAL

execute if score @s SS_ui_tutorial matches 0 run title @s title hud:tutorial:
execute if score @s SS_ui_tutorial matches 1 run titleraw @s title {"rawtext":[{ "text": "hud:tutorial:" },{"translate":"spark.tutorial.1", "with": [ "\n" ] }]}
execute if score @s SS_ui_tutorial matches 2 run titleraw @s title {"rawtext":[{ "text": "hud:tutorial:" },{"translate":"intro.ilum.tutorial_message.follow_kelleran.message1", "with": [ "\n" ] }]}
execute if score @s SS_ui_tutorial matches 3 run titleraw @s title {"rawtext":[{ "text": "hud:tutorial:" },{"translate":"intro.ilum_caves.tutorial_message.pull.message1", "with": [ "\n" ] }]}
execute if score @s SS_ui_tutorial matches 4 run titleraw @s title {"rawtext":[{ "text": "hud:tutorial:" },{"translate":"intro.ilum.tutorial_message.the_calling.message1", "with": [ "\n" ] }]}

# crucible sequence
execute if score @s SS_ui_tutorial matches 5 run titleraw @s title {"rawtext":[{ "text": "hud:tutorial:" },{"translate":"intro.crucible.tutorial_message.talk_to_kelleran.message1", "with": [ "\n" ] }]}
execute if score @s SS_ui_tutorial matches 6 run titleraw @s title {"rawtext":[{ "text": "hud:tutorial:" },{"translate":"intro.craft_lightsaber.tutorial_message.use_craft_table.message1", "with": [ "\n" ] }]}
execute if score @s SS_ui_tutorial matches 7 run titleraw @s title {"rawtext":[{ "text": "hud:tutorial:" },{"translate":"intro.craft_lightsaber.tutorial_message.ignite.message1", "with": [ "\n" ] }]}
execute if score @s SS_ui_tutorial matches 8 run titleraw @s title {"rawtext":[{ "text": "hud:tutorial:" },{"translate":"intro.craft_lightsaber.tutorial_message.go_to_training_room.message1", "with": [ "\n" ] }]}
execute if score @s SS_ui_tutorial matches 9 run titleraw @s title {"rawtext":[{ "text": "hud:tutorial:" },{"translate":"intro.training_room.tutorial_message.stand_in_center.message1", "with": [ "\n" ] }]}
execute if score @s SS_ui_tutorial matches 10 run titleraw @s title {"rawtext":[{ "text": "hud:tutorial:" },{"translate":"intro.training_room.tutorial_message.press_to_attack.message1", "with": [ "\n" ] }]}
execute if score @s SS_ui_tutorial matches 11 run titleraw @s title {"rawtext":[{ "text": "hud:tutorial:" },{"translate":"intro.training_room.tutorial_message.press_to_guard.message1", "with": [ "\n" ] }]}
execute if score @s SS_ui_tutorial matches 12 run titleraw @s title {"rawtext":[{ "text": "hud:tutorial:" },{"translate":"intro.training_room.tutorial_message.select_ability.message1", "with": [ "\n" ] }]}
execute if score @s SS_ui_tutorial matches 13 run titleraw @s title {"rawtext":[{ "text": "hud:tutorial:" },{"translate":"spark.ui.waiting", "with": [ "\n" ] }]}
execute if score @s SS_ui_tutorial matches 14 run titleraw @s title {"rawtext":[{ "text": "hud:tutorial:" },{"translate":"intro.droid_crafting.tutorial_message.find_room.message1", "with": [ "\n" ] }]}
execute if score @s SS_ui_tutorial matches 15 run titleraw @s title {"rawtext":[{ "text": "hud:tutorial:" },{"translate":"intro.droid_crafting.tutorial_message.collect_tools.message1", "with": [ "\n" ] }]}
execute if score @s SS_ui_tutorial matches 16 run titleraw @s title {"rawtext":[{ "text": "hud:tutorial:" },{"translate":"intro.droid_crafting.tutorial_message.use_powercell.message1", "with": [ "\n" ] }]}
execute if score @s SS_ui_tutorial matches 17 run titleraw @s title {"rawtext":[{ "text": "hud:tutorial:" },{"translate":"intro.craft_lightsaber.tutorial_message.ignite.message1", "with": [ "\n" ] }]}

execute if score @s SS_ui_tutorial matches 20 run titleraw @s title {"rawtext":[{ "text": "hud:tutorial:" },{"translate":"lightsaber_dueling.tutorial_message.follow_kelleran.message1", "with": [ "\n" ] }]}
execute if score @s SS_ui_tutorial matches 21 run titleraw @s title {"rawtext":[{ "text": "hud:tutorial:" },{"translate":"lightsaber_dueling.tutorial_message.stand_in_circle.message1", "with": [ "\n" ] }]}

execute if score @s SS_ui_tutorial matches 30 run titleraw @s title {"rawtext":[{ "text": "hud:tutorial:" },{"translate":"arena.tutorial_message.follow.message1", "with": [ "\n" ] }]}
execute if score @s SS_ui_tutorial matches 31 run titleraw @s title {"rawtext":[{ "text": "hud:tutorial:" },{"translate":"arena.tutorial_message.soothe_monster.message1", "with": [ "\n" ] }]}

execute if score @s SS_ui_tutorial matches 40 run titleraw @s title {"rawtext":[{ "text": "hud:tutorial:" },{"translate":"coruscant.main_hall.tutorial.quests", "with": [ "\n" ] }]}
execute if score @s SS_ui_tutorial matches 41 run titleraw @s title {"rawtext":[{ "text": "hud:tutorial:" },{"translate":"coruscant.main_hall.tutorial.quest_yoda", "with": [ "\n" ] }]}
execute if score @s SS_ui_tutorial matches 42 run titleraw @s title {"rawtext":[{ "text": "hud:tutorial:" },{"translate":"spark.tutorial.42", "with": [ "\n" ] }]}
execute if score @s SS_ui_tutorial matches 43 run titleraw @s title {"rawtext":[{ "text": "hud:tutorial:" },{"translate":"spark.tutorial.43", "with": [ "\n" ] }]}
execute if score @s SS_ui_tutorial matches 44 run titleraw @s title {"rawtext":[{ "text": "hud:tutorial:" },{"translate":"spark.tutorial.44", "with": [ "\n" ] }]}
execute if score @s SS_ui_tutorial matches 45 run titleraw @s title {"rawtext":[{ "text": "hud:tutorial:" },{"translate":"spark.tutorial.45", "with": [ "\n" ] }]}
execute if score @s SS_ui_tutorial matches 46 run titleraw @s title {"rawtext":[{ "text": "hud:tutorial:" },{"translate":"spark.tutorial.46", "with": [ "\n" ] }]}
execute if score @s SS_ui_tutorial matches 47 run titleraw @s title {"rawtext":[{ "text": "hud:tutorial:" },{"translate":"spark.tutorial.47", "with": [ "\n" ] }]}
execute if score @s SS_ui_tutorial matches 48 run titleraw @s title {"rawtext":[{ "text": "hud:tutorial:" },{"translate":"spark.tutorial.48", "with": [ "\n" ] }]}
execute if score @s SS_ui_tutorial matches 49 run titleraw @s title {"rawtext":[{ "text": "hud:tutorial:" },{"translate":"spark.tutorial.49", "with": [ "\n" ] }]}

execute if score @s SS_ui_tutorial matches 50 run titleraw @s title {"rawtext":[{ "text": "hud:tutorial:" },{"translate":"droid_survival.task.defeat_droids.task1", "with": [ "\n" ] }]}
execute if score @s SS_ui_tutorial matches 51 run titleraw @s title {"rawtext":[{ "text": "hud:tutorial:" },{"translate":"spark.tutorial.51", "with": [ "\n" ] }]}
execute if score @s SS_ui_tutorial matches 52 run titleraw @s title {"rawtext":[{ "text": "hud:tutorial:" },{"translate":"spark.tutorial.52", "with": [ "\n" ] }]}
execute if score @s SS_ui_tutorial matches 53 run titleraw @s title {"rawtext":[{ "text": "hud:tutorial:" },{"translate":"spark.tutorial.53", "with": [ "\n" ] }]}
execute if score @s SS_ui_tutorial matches 56 run titleraw @s title {"rawtext":[{ "text": "hud:tutorial:" },{"translate":"spark.tutorial.56", "with": [ "\n" ] }]}
execute if score @s SS_ui_tutorial matches 54 run titleraw @s title {"rawtext":[{ "text": "hud:tutorial:" },{"translate":"spark.tutorial.54", "with": [ "\n" ] }]}
execute if score @s SS_ui_tutorial matches 55 run titleraw @s title {"rawtext":[{ "text": "hud:tutorial:" },{"translate":"spark.tutorial.55", "with": [ "\n" ] }]}
execute if score @s SS_ui_tutorial matches 57 run titleraw @s title {"rawtext":[{ "text": "hud:tutorial:" },{"translate":"spark.tutorial.57", "with": [ "\n" ] }]}
execute if score @s SS_ui_tutorial matches 58 run titleraw @s title {"rawtext":[{ "text": "hud:tutorial:" },{"translate":"spark.tutorial.58", "with": [ "\n" ] }]}
execute if score @s SS_ui_tutorial matches 59 run titleraw @s title {"rawtext":[{ "text": "hud:tutorial:" },{"translate":"spark.tutorial.59", "with": [ "\n" ] }]}

# escape level
execute if score @s SS_ui_tutorial matches 5001 run titleraw @s title {"rawtext":[{ "text": "hud:tutorial:" },{"translate":"spark.tutorial.5001", "with": [ "\n" ] }]}

# puzzle level
execute if score @s SS_ui_tutorial matches 6001 run titleraw @s title {"rawtext":[{ "text": "hud:tutorial:" },{"translate":"puzzle.planet_2.tutorial_message.follow_path.message1", "with": [ "\n" ] }]}