# © Spark Universe, 2023
# authors: Arcaniax, FetchBot
# description: runs 1/s 
# called by: main loop

#execute as @e[type=spark:tutorial_button] at @s if entity @a[rm=15,tag=!start_music] run music play sound.spark.ambience_start_room 1.0 0.1 loop
#execute as @e[type=spark:tutorial_button] at @s if entity @a[rm=15,tag=!start_music] run tag @a add start_music


particle spark:star_dust 3047 -46.0 2945

execute if score .state tutorial matches 0 run function spark/tutorial/blackbox_tick20
execute as @a[x=3346,dx=84,y=29,dy=30,z=-132,dz=275] run function spark/tutorial/chap4/quest_giver_task

#elevator fade out fallback
scoreboard players add @a elevator_timer 0
scoreboard players remove @a[scores={elevator_timer=1..},tag=!hide_ui] elevator_timer 1
execute as @a[scores={elevator_timer=0},tag=!hide_ui] run title @s actionbar hud:fade_in_0
execute as @a[scores={elevator_timer=0},tag=!hide_ui] run scoreboard players set @s elevator_timer -1