# © Spark Universe, 2023
# authors: William Savage
# description: runs 20/s 
# called by: chap3/loop

# post show of holographic lightsaber construction

# fade out, teleport, allow input, adventure mode
# execute if score .timer tutorial matches 1 run title @a actionbar hud:fade_in_1
execute if score .timer tutorial matches 1 run gamemode adventure @a
# execute if score .timer tutorial matches 1 run tp @a 3027 -56 3031
# execute if score .timer tutorial matches 1 run inputpermission set @a movement enabled
# execute if score .timer tutorial matches 1 run inputpermission set @a camera enabled

#
execute if score .timer tutorial matches 1 run scoreboard players set .load_area tutorial 0
execute if score .timer tutorial matches 1.. if blocks 3019.44 -56.00 3033.48 3019.44 -56.00 3033.48 3019.44 -56.00 3033.48 all run scoreboard players add .load_area tutorial 1

# change dialog
execute if score .load_area tutorial matches 1 positioned 3019.44 -56.00 3033.48 unless entity @e[type=spark:master_huyang,r=4] run summon spark:master_huyang 3019.44 -56.00 3033.48 facing 3041 -55 3033
execute if score .load_area tutorial matches 11 positioned 3019.44 -56.00 3033.48 unless entity @e[type=spark:master_huyang,r=4] run summon spark:master_huyang 3019.44 -56.00 3033.48 facing 3041 -55 3033
execute if score .load_area tutorial matches 12 positioned 3019.44 -56.00 3033.48 run event entity @e[type=spark:master_huyang,c=1] spark:quest_npc
execute if score .load_area tutorial matches 13 positioned 3019.44 -56.00 3033.48 run dialogue change @e[type=spark:master_huyang,r=1] spark:crucible.huyang_2

# tag for particle effect
execute if score .load_area tutorial matches 12 positioned 3019.44 -56.00 3033.48 run tag @e[type=spark:master_huyang,c=1,r=1] add tall
execute if score .load_area tutorial matches 12 positioned 3019.44 -56.00 3033.48 run tag @e[type=spark:master_huyang,c=1,r=1] add has_quest


# set task when on player finished the dialog
execute if score .npc_trigger tutorial matches 1 run scoreboard players set @a SS_ui_task 3
execute if score .npc_trigger tutorial matches 1 run playsound sound.spark.receive_lightsaber_parts @a

# disable npc on huyang, transform into self
execute if score .npc_trigger tutorial matches 1 positioned 3021 -56 3030 run event entity @e[type=spark:master_huyang,c=1] spark:reset_npc

execute if score .npc_trigger tutorial matches 1 run function spark/tutorial/next