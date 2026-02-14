#teleport @s 3028 -56 3071 180 0
scoreboard players reset @s tut_i_bots
scoreboard players reset @s tut_i_counter
scoreboard players reset @s tut_i_deflect
scoreboard players reset @s tut_i_times
scoreboard players reset @s tut_instances
scoreboard players set @s SS_ui_task 0

#title @a actionbar hud:fade_in_1
tag @s remove assigned
tag @s add instance_finished