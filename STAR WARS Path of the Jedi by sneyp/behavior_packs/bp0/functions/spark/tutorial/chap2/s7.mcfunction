# © Spark Universe, 2023
# authors: Arcaniax
# description: runs 20/s 
# called by: tutorial/loop

# YODA INTRO CUTSCENE

execute if score .timer tutorial matches 0 run scoreboard players set @a SS_ui_tutorial 0





# execute if score .timer tutorial matches 0 run gamemode spectator @a

# execute if score .timer tutorial matches 0 run tp @a 27.5 -7.35 3019.5 facing @e[type=spark:yoda,c=1]
# execute if score .timer tutorial matches 1..250 as @a at @s run tp @s ~-.1 ~-.05 ~ facing @e[type=spark:yoda,c=1]

execute if score .timer tutorial matches 1 run function spark/tutorial/next