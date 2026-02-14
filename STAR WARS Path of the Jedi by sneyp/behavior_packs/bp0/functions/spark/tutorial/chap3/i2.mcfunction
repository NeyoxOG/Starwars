# © Spark Universe, 2023
# authors: William Savage
# description: runs 20/s 
# called by: chap3/s10 -> chap3/_iloop

execute if score @s tut_i_times matches 0 run scoreboard players set @s tut_i_counter 61

# remove task
execute if score @s tut_i_times matches 20 run scoreboard players set @s SS_ui_task 0


# counter stuff
scoreboard players add @s tut_i_counter 0
scoreboard players add .div tut_i_counter 0

# return to center
#execute if score @s tut_i_times matches 40 run scoreboard players set @s SS_ui_tutorial 9
execute if score @s tut_i_times matches 21 run playsound sound.spark.quest_minor @s

# play particle effect in center every 10 ticks
#execute if score @s tut_i_times matches 40.. run scoreboard players operation .div tut_i_counter = .timer tutorial
#execute if score @s tut_i_times matches 40.. run scoreboard players operation .div tut_i_counter %= _10 SS_const
#execute if score @s tut_i_times matches 40.. run execute if score .div tut_i_counter matches 0 positioned ~~~ run particle spark:duel_circle_fireflies ~ ~ ~

# if player within circle, goto next
execute if score @s tut_i_times matches 21.. run execute positioned ~~~ as @s if entity @s[r=30] run function spark/tutorial/chap3/_inext