# © Spark Universe, 2023
# authors: William Savage
# description: runs 20/s 
# called by: chap3/s10 -> chap3/_iloop

# detect when the player is using these to destroy a training mob...

# for now we will have detect kills only
execute if score @s tut_i_times matches 3 as @s run scoreboard players set .force_kills tut_i_counter 0
execute if score @s tut_i_times matches 3 as @s run summon spark:marksman_droid ~6 ~1.6 ~ 0 0 spark:force_training
execute if score @s tut_i_times matches 4 as @s run summon spark:marksman_droid ~ ~1.6 ~6 0 0 spark:force_training
execute if score @s tut_i_times matches 5 as @s run summon spark:marksman_droid ~-6 ~1.6 ~ 0 0 spark:force_training

# temp warning
# execute if score @s tut_i_times matches 6 run titleraw @s actionbar {"rawtext":[{ "text": "hud:warning:Force power detection not implemented!" }]}

# set task
execute if score @s tut_i_times matches 3 run scoreboard players set @s SS_ui_task 7
execute if score @s tut_i_times matches 3 run scoreboard players set @s SS_ui_tutorial 12

# calculate when to add a new bot
execute if score @s tut_i_times matches 6.. run scoreboard players set @s tut_i_bots 0
execute if score @s tut_i_times matches 6.. run execute as @e[type=spark:marksman_droid,r=20] run execute as @p[r=18] run scoreboard players add @s tut_i_bots 1

# if bot value is ..2, spawn a new bot until we have finished deflecting
# execute if score @s tut_i_times matches 6.. if score @s tut_i_bots matches ..2 run scoreboard players add @s tut_i_deflect 1
#execute if score @s tut_i_times matches 6.. if score @s tut_i_bots matches ..2 run scoreboard players add .force_kills tut_i_counter 1
execute if score @s tut_i_times matches 6.. if score @s tut_i_bots matches ..2 run scoreboard players random .random tutorial 1 4
execute if score @s tut_i_times matches 6.. if score @s tut_i_bots matches ..2 if score .random tutorial matches 1 run summon spark:marksman_droid ~6 ~1.6 ~ facing @p spark:force_training
execute if score @s tut_i_times matches 6.. if score @s tut_i_bots matches ..2 if score .random tutorial matches 2 run summon spark:marksman_droid ~-6 ~1.6 ~ facing @p spark:force_training
execute if score @s tut_i_times matches 6.. if score @s tut_i_bots matches ..2 if score .random tutorial matches 3 run summon spark:marksman_droid ~ ~1.6 ~6 facing @p spark:force_training
execute if score @s tut_i_times matches 6.. if score @s tut_i_bots matches ..2 if score .random tutorial matches 4 run summon spark:marksman_droid ~ ~1.6 ~-6 facing @p spark:force_training

#
execute if score @s tut_i_times matches 6.. run scoreboard players operation @s tut_i_bots = .force_kills tut_i_counter

# when all three are killed (@s tut_i_bot = 3), go next
execute if score @s tut_i_times matches 6.. if score .force_kills tut_i_counter matches 3.. run playsound sound.spark.success_medium @p

# next state
execute if score @s tut_i_times matches 6.. if score .force_kills tut_i_counter matches 3.. run function spark/tutorial/chap3/_inext

# skip
execute if score @s tut_i_times matches 0 run function spark/tutorial/chap3/_inext