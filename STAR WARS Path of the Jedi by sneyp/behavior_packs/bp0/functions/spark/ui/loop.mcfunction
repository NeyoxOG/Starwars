# © Spark Universe, 2023
# authors: Arcaniax
# description: Game loop, runs 20 times a second
# called by: main loop

scoreboard objectives add SS_ui_time dummy
scoreboard objectives add SS_ui_last_w dummy
scoreboard objectives add SS_ui_last_i dummy

scoreboard players add ui_clock SS_time 1

execute as @a[tag=hide_ui] run title @s title hud:hide_ui

execute as @a[tag=!hide_ui] run title @s title hud:clear

execute as @a[tag=!hide_ui] if score @s SS_ui_info matches 1.. run scoreboard players operation @s SS_ui_last_i = @s SS_ui_info
execute as @a[tag=!hide_ui] if score @s SS_ui_info matches 1.. run scoreboard players set @s SS_ui_time 150
execute as @a[tag=!hide_ui] if score @s SS_ui_info matches 1.. run playsound spark.zombies2.gamestate.ui_notification @s
execute as @a[tag=!hide_ui] if score @s SS_ui_info matches 1.. run scoreboard players set @s SS_ui_last_w 0
execute as @a[tag=!hide_ui] if score @s SS_ui_info matches 1.. run scoreboard players set @s SS_ui_info 0

execute as @a[tag=!hide_ui] if score @s SS_ui_warning matches 1.. run scoreboard players operation @s SS_ui_last_w = @s SS_ui_warning
execute as @a[tag=!hide_ui] if score @s SS_ui_warning matches 1.. run scoreboard players set @s SS_ui_time 50
execute as @a[tag=!hide_ui] if score @s SS_ui_warning matches 1.. run playsound spark.zombies2.gamestate.ui_notification @s
execute as @a[tag=!hide_ui] if score @s SS_ui_warning matches 1.. run scoreboard players set @s SS_ui_last_i 0
execute as @a[tag=!hide_ui] if score @s SS_ui_warning matches 1.. run scoreboard players set @s SS_ui_info 0
execute as @a[tag=!hide_ui] if score @s SS_ui_warning matches 1.. run scoreboard players set @s SS_ui_warning 0

execute as @a if score @s SS_ui_time matches 1.. run scoreboard players add @s SS_ui_time -1

execute as @a if score @s SS_ui_time matches 0 run scoreboard players set @s SS_ui_last_i 0
execute as @a if score @s SS_ui_time matches 0 run scoreboard players set @s SS_ui_last_w 0

execute as @a[tag=!hide_ui] if score ui_clock SS_time matches 1 run function spark/ui/tick/0
execute as @a[tag=!hide_ui] if score ui_clock SS_time matches 2 run function spark/ui/tick/1
execute as @a[tag=!hide_ui] if score ui_clock SS_time matches 3 run function spark/ui/tick/2
execute as @a[tag=!hide_ui] if score ui_clock SS_time matches 4 run function spark/ui/tick/3
execute as @a[tag=!hide_ui] if score ui_clock SS_time matches 5 run function spark/ui/tick/4
execute as @a[tag=!hide_ui] if score ui_clock SS_time matches 6 run function spark/ui/tick/5

scoreboard players operation ui_clock SS_time %= _6 SS_const


# execute as @a[tag=!hide_ui] if score slow SS_time matches 5 run function spark/ui/tick/0
# execute as @a[tag=!hide_ui] if score slow SS_time matches 6 run function spark/ui/tick/1
# execute as @a[tag=!hide_ui] if score slow SS_time matches 7 run function spark/ui/tick/2
# execute as @a[tag=!hide_ui] if score slow SS_time matches 8 run function spark/ui/tick/3
# execute as @a[tag=!hide_ui] if score slow SS_time matches 9 run function spark/ui/tick/4

# execute as @a[tag=!hide_ui] if score slow SS_time matches 10 run function spark/ui/tick/0
# execute as @a[tag=!hide_ui] if score slow SS_time matches 11 run function spark/ui/tick/1
# execute as @a[tag=!hide_ui] if score slow SS_time matches 12 run function spark/ui/tick/2
# execute as @a[tag=!hide_ui] if score slow SS_time matches 13 run function spark/ui/tick/3
# execute as @a[tag=!hide_ui] if score slow SS_time matches 14 run function spark/ui/tick/4

# execute as @a[tag=!hide_ui] if score slow SS_time matches 15 run function spark/ui/tick/0
# execute as @a[tag=!hide_ui] if score slow SS_time matches 16 run function spark/ui/tick/1
# execute as @a[tag=!hide_ui] if score slow SS_time matches 17 run function spark/ui/tick/2
# execute as @a[tag=!hide_ui] if score slow SS_time matches 18 run function spark/ui/tick/3
# execute as @a[tag=!hide_ui] if score slow SS_time matches 19 run function spark/ui/tick/4