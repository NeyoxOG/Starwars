# © Spark Universe, 2023
# authors: William Savage
# description: runs 20/s 
# called by: chap3/s10 -> chap3/_iloop

#
execute if score @s tut_i_times matches 1 positioned ~~~ run event entity @e[type=spark:activation_circle,r=5] spark:disable

# clear hud
execute if score @s tut_i_times matches 0 run titleraw @s actionbar {"rawtext":[{ "text": "hud:clear" }]}

# set scoreboard value of droids to 3
execute if score @s tut_i_times matches 1 run scoreboard players set @s tut_i_bots 0

# summon training dummies around the player while they are in the center
execute if score @s tut_i_times matches 5 as @s run playsound sound.spark.duel_begin @s
execute if score @s tut_i_times matches 5 as @s run summon spark:marksman_droid ~6 ~1.6 ~ 0 0 spark:track_player
execute if score @s tut_i_times matches 5 as @s run summon spark:marksman_droid ~ ~1.6 ~6 0 0 spark:track_player
execute if score @s tut_i_times matches 5 as @s run summon spark:marksman_droid ~-6 ~1.6 ~ 0 0 spark:track_player

execute if score @s tut_i_times matches 5 as @s run tag @e[type=spark:marksman_droid,r=15] add force_proof

# count the number of droids alive, if its 0, next section
# 3 - number of counted bots = amount killed

# set task 
execute if score @s tut_i_times matches 6 run scoreboard players set @s SS_ui_task 5
execute if score @s tut_i_times matches 6 run scoreboard players set @s SS_ui_tutorial 10

execute if score @s tut_i_times matches 6.. run scoreboard players set @s SS_temp 0
execute if score @s tut_i_times matches 6.. run execute as @e[type=spark:marksman_droid,r=20] run execute as @p[r=18] run scoreboard players remove @s SS_temp 1
execute if score @s tut_i_times matches 6.. run scoreboard players add @s SS_temp 3
execute if score @s tut_i_times matches 6.. run scoreboard players operation @s tut_i_bots = @s SS_temp

# remove tutorial when one bot has been killed
execute if score @s tut_i_times matches 6.. if score @s tut_i_bots matches 3 run scoreboard players set @s SS_ui_tutorial 0

# when all three are killed (@s tut_i_bot = 3), go next
#execute if score @s tut_i_times matches 6.. if score @s tut_i_bots matches 3 run titleraw @s actionbar {"rawtext":[{ "text": "hud:announce:" },{"translate":"intro.training_room.announcement.passed_tests.announcement1", "with": [ "\n" ] }]}
execute if score @s tut_i_times matches 6.. if score @s tut_i_bots matches 3 run playsound sound.spark.success_minor @s

# next state
execute if score @s tut_i_times matches 6.. if score @s tut_i_bots matches 3 run function spark/tutorial/chap3/_inext