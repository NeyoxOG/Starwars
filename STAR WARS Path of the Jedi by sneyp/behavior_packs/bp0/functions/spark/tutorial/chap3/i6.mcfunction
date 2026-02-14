# © Spark Universe, 2023
# authors: William Savage
# description: runs 20/s 
# called by: chap3/s10 -> chap3/_iloop

# exit location 3028 -56 3071 180 0

# cutscefne for final blow (not sure if it will be implemented at all)
execute if score @s tut_i_times matches 1 run titleraw @s actionbar {"rawtext":[{ "text": "hud:announce:" },{"translate":"intro.training_room.announcement.passed_tests.announcement1", "with": [ "\n" ] }]}
execute if score @s tut_i_times matches 1 run kill @e[type=spark:marksman_droid]
execute if score @s tut_i_times matches 20 run scoreboard players set @s SS_ui_task 0

#
execute if score @s tut_i_times matches 1 run scoreboard players set @s SS_ui_tutorial 0

# fade out and in, teleport player back into main area and pass along 
execute if score @s tut_i_times matches 25 run titleraw @s actionbar {"rawtext":[{ "text": "hud:clear" }]}
execute if score @s tut_i_times matches 25 run function spark/tutorial/chap3/_leave