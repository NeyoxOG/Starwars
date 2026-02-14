# © Spark Universe, 2023
# authors: Arcaniax
# description: runs 20/s 
# called by: tutorial/loop

# CHOOSE RANDOM PATH

#TODO RANDOMIZE
#TODO REPLACE FILLS WITH ACTUAL BUILDS

execute if score .timer tutorial matches 0 run playsound sound.spark.ilum_cave_quake @a
execute if score .timer tutorial matches 0 run camerashake add @a 1 1
execute if score .timer tutorial matches 20 run camerashake add @a 0.75 1
execute if score .timer tutorial matches 40 run camerashake add @a 0.5 1
execute if score .timer tutorial matches 60 run camerashake add @a 0.25 2


execute if score .timer tutorial matches 60 run scoreboard players set @s SS_ui_tutorial 4

# FILLS
execute if score .timer tutorial matches 1 run scoreboard players set .star_call tutorial 0

## disable middle path
#execute if score .timer tutorial matches 1 if score .ice_path tutorial matches 2 run scoreboard players set .ice_path tutorial 3



# execute if score .timer tutorial matches 1 run kill @e[type=spark:marker,family=star_call]
# execute if score .timer tutorial matches 1 run tag @e[type=spark:marker] add old
# execute if score .timer tutorial matches 1 run summon spark:marker -163.5 -28.00 3045.5 0 0 spark:star_call
# execute if score .timer tutorial matches 1 run tag @e[type=spark:marker,tag=!old] add calling_star
#execute if score .timer tutorial matches 20 run fill -197 -25 3030 -183 -15 3030 ice
#execute if score .timer tutorial matches 20 run fill -218 -28 3060 -218 -19 3046 ice

#execute if score .timer tutorial matches 0 run inputpermission set @a movement disabled

#execute if score .timer tutorial matches 60.. run title @a actionbar Use Force Insight

#execute if score .timer tutorial matches 80.. if entity @e[type=spark:marker,tag=insight] run function spark/tutorial/next

execute if score .timer tutorial matches 60.. run function spark/tutorial/next