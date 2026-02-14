# © Spark Universe, 2023
# authors: William Savage
# description: on lightsaber customisation finished for the first time 
# called by: dialog

titleraw @s actionbar {"rawtext":[{ "text": "hud:announce:" },{"translate":"intro.craft_lightsaber.announcement.crafting_completed.announcement1", "with": [ "\n" ] }]}
playsound sound.spark.success_medium @s
scoreboard players set @s SS_ui_task 0

# give player inignited item
event entity @s unlock_lightsaber
tag @s add lightsaber_received

# detect when ignited (animation controller or something)
# player special ignite sound
# single use trigger for next state
# npc_trigger tutorial 1