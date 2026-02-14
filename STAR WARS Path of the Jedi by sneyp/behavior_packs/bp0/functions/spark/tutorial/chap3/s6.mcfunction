# © Spark Universe, 2023
# authors: William Savage
# description: runs 20/s 
# called by: chap3/loop

#
execute if score .timer tutorial matches 2 run scoreboard players set @a SS_ui_tutorial 17

# change kelleran's head effect 
execute if score .timer tutorial matches 1 run tag @e[type=spark:lightsaber_crafting_table] remove has_quest
execute if score .npc_trigger tutorial matches 0 if entity @a[tag=lightsaber_unlocked] if score .timer tutorial matches 1.. positioned 3027.52 -56.00 3033.56 run tag @e[type=spark:kelleran_beq,c=1,r=10] add has_quest
execute if score .npc_trigger tutorial matches 0 if score .timer tutorial matches 1 positioned 3027.52 -56.00 3033.56 run event entity @e[type=spark:kelleran_beq,c=1,r=1] spark:quest_npc
# change to dialog
execute if score .npc_trigger tutorial matches 0 if score .timer tutorial matches 2 positioned 3027.52 -56.00 3033.56 run dialogue change @e[type=spark:kelleran_beq,c=1] spark:crucible.kelleran_3

# music
# execute if score .npc_trigger tutorial matches 1 run music play sound.spark.music_yoda_younglings2 1.0 0.1
# execute if score .npc_trigger tutorial matches 1 run music queue sound.spark.music_yoda_younglings1 1.0 0.1 loop

# count the number of players in the crafting room
# if they all have ignited blades continue
execute if score .npc_trigger tutorial matches 1 run scoreboard players set .count tutorial 0
execute if score .npc_trigger tutorial matches 1 run execute as @a[x=3040,y=-43,z=3015,dx=-40,dy=-20,dz=32] run scoreboard players add .count tutorial 1
execute if score .npc_trigger tutorial matches 1 run execute as @a[x=3040,y=-43,z=3015,dx=-40,dy=-20,dz=32,tag=lightsaber_unlocked] run scoreboard players remove .count tutorial 1

# remove tutorial message if they have ignited
execute if score .npc_trigger tutorial matches 0 run execute as @a[x=3040,y=-43,z=3015,dx=-40,dy=-20,dz=32,tag=lightsaber_unlocked] run scoreboard players set @s SS_ui_tutorial 0

# if still waiting, notify those who are waiting
execute if score .npc_trigger tutorial matches 1 if score .count tutorial matches 1.. run execute as @a[x=3040,y=-43,z=3015,dx=-40,dy=-20,dz=32,tag=lightsaber_unlocked] run titleraw @s actionbar {"rawtext":[{ "text": "hud:hint:" },{"translate":"intro.training_room.tutorial_message.waiting.message1", "with": [ "\n" ] }]}

# escape to next set
execute if score .npc_trigger tutorial matches 1 if score .count tutorial matches 0 run titleraw @a actionbar {"rawtext":[{ "text": "hud:clear" }]}
execute if score .npc_trigger tutorial matches 1 if score .count tutorial matches 0 run function spark/tutorial/next