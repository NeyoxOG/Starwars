# © Spark Universe, 2023
# authors: William Savage
# description: runs 20/s 
# called by: chap3/loop

execute if score .timer tutorial matches 1 run tag @e[type=spark:lightsaber_crafting_table] add has_quest

execute if score .npc_trigger tutorial matches 0 if score .timer tutorial matches 1 run scoreboard players add @a tutorial 0

# Use one of the Lightsaber Crafting Tables, Play minor quest sound
#execute if score .npc_trigger tutorial matches 0 if score .timer tutorial matches 40 run scoreboard players set @a SS_ui_tutorial 6
execute if score .npc_trigger tutorial matches 0 if score .timer tutorial matches 40 run playsound sound.spark.quest_minor @a

# make crafting benches interactable
execute if score .npc_trigger tutorial matches 0 if score .timer tutorial matches 36 positioned 3027 -56 3027 run event entity @e[type=spark:lightsaber_ui_npc,r=3] spark:enable_crafting
execute if score .npc_trigger tutorial matches 0 if score .timer tutorial matches 36 positioned 3023 -56 3027 run event entity @e[type=spark:lightsaber_ui_npc,r=3] spark:enable_crafting
execute if score .npc_trigger tutorial matches 0 if score .timer tutorial matches 36 positioned 3023 -56 3043 run event entity @e[type=spark:lightsaber_ui_npc,r=3] spark:enable_crafting
execute if score .npc_trigger tutorial matches 0 if score .timer tutorial matches 36 positioned 3034 -56 3038 run event entity @e[type=spark:lightsaber_ui_npc,r=3] spark:enable_crafting

execute if score .npc_trigger tutorial matches 0 if score .timer tutorial matches 38 positioned 3027 -56 3027 run dialogue change @e[type=spark:lightsaber_ui_npc,r=2] gui.lightsaber_custom_stance:single @a
execute if score .npc_trigger tutorial matches 0 if score .timer tutorial matches 38 positioned 3023 -56 3027 run dialogue change @e[type=spark:lightsaber_ui_npc,r=2] gui.lightsaber_custom_stance:single @a
execute if score .npc_trigger tutorial matches 0 if score .timer tutorial matches 38 positioned 3023 -56 3043 run dialogue change @e[type=spark:lightsaber_ui_npc,r=2] gui.lightsaber_custom_stance:single @a
execute if score .npc_trigger tutorial matches 0 if score .timer tutorial matches 38 positioned 3034 -56 3038 run dialogue change @e[type=spark:lightsaber_ui_npc,r=2] gui.lightsaber_custom_stance:single @a

# at this point we take a small break from functions
# when ANY player gets their main lightsaber, we will continue from here

# if a player has received a lightsaber, wait 4 seconds to tell them to ignite SS_ui_tutorial 7
execute if score .npc_trigger tutorial matches 0 run execute as @a[tag=lightsaber_received] run function spark/tutorial/next

#
execute if score .npc_trigger tutorial matches 0 if score .timer tutorial matches 1 run tag @e[type=spark:lightsaber_crafting_table] add has_quest

# execute if score .npc_trigger tutorial matches 0 run execute as @a[hasitem={item=spark:lightsaber_hilt,quantity=1..}] run scoreboard players add @s tutorial 1
# execute if score .npc_trigger tutorial matches 0 run execute as @a[hasitem={item=spark:lightsaber_01_single,quantity=0}] if score @s tutorial matches 60 run scoreboard players set @s SS_ui_tutorial 7
# execute if score .npc_trigger tutorial matches 0 run execute as @a[hasitem={item=spark:lightsaber_01_single,quantity=0}] if score @s tutorial matches 60 run playsound sound.spark.quest_medium @s

# # remove tutorial message
# execute if score .npc_trigger tutorial matches 0 run execute as @a[hasitem={item=spark:lightsaber_01_single,quantity=1..}] run scoreboard players set @s SS_ui_tutorial 0
