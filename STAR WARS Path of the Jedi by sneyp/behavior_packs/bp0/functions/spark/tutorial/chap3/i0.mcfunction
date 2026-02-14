# © Spark Universe, 2023
# authors: William Savage
# description: runs 20/s 
# called by: chap3/s10 -> chap3/_iloop

# setup function, we have already been teleported, wait 10 ticks, then summon door
# ticks come from @s tut_i_times
# everything is from @s

# counter thing
scoreboard players add @s tut_i_counter 0
scoreboard players add .div tut_i_counter 0

# summon door
execute if score @s tut_i_times matches 5 run summon spark:crucible_gate_large ~~~-14 0 0 spark:door_north

# unblacken
execute if score @s tut_i_times matches 25 run title @s actionbar hud:fade_in_1

#play message to notify about how to begin
execute if score @s tut_i_times matches 40 run scoreboard players set @s SS_ui_tutorial 9
execute if score @s tut_i_times matches 40 run playsound sound.spark.quest_minor @s

#
execute if score @s tut_i_times matches 1 positioned ~~~ run summon spark:activation_circle ~ ~ ~ 0 0 spark:enable

# play particle effect in center every 10 ticks
#scoreboard players operation .div tut_i_counter = .timer tutorial
#scoreboard players operation .div tut_i_counter %= _10 SS_const
#execute if score .div tut_i_counter matches 0 positioned ~~~ run particle spark:duel_circle_fireflies ~ ~ ~

# if player within circle, goto next
execute positioned ~~~ as @s if entity @s[r=3] run function spark/tutorial/chap3/_inext
