#particle spark:npc_exclamation ~ ~ ~

#chunk loading
execute if score @s elevator matches 3 positioned 9200 37 9006 run tickingarea add ^^^-3.5 ^^^ spark.elevator.target 
execute if score @s elevator matches 2 positioned 9000 22 9005 run tickingarea add ^^^-3.5 ^^^ spark.elevator.target 
execute if score @s elevator matches 1 positioned 8838.5 27 8929.5 run tickingarea add ^^^-3.5 ^^^ spark.elevator.target 
execute if score @s elevator matches 0 positioned 3270 79 -20 run tickingarea add ^^^-3.5 ^^^40 spark.elevator.target 
execute if score @s elevator matches -1 positioned 9011.5 26 9159.5 run tickingarea add ^^^-3.5 ^^^ spark.elevator.target 
execute at @s run tickingarea add ~~~ ~~~ spark.elevator.current

tag @a[r=10] add elevator_tmp

#Time in seconds before fade out gets forcefully removed (in case something goes wrong so the player isn't in perpetual blackscreen). Doesn't count down while player has hide_ui tag!
scoreboard players set @a[tag=elevator_tmp] elevator_timer 4


title @a[r=10] actionbar hud:fade_out_1
scoreboard players set .elevator_tmp SS_tmp 0
execute as @a[r=10] run scoreboard players add .elevator_tmp SS_tmp 1
execute if score .elevator_tmp SS_tmp matches 2.. run tag @a[r=10] add elevator_spread
# Just for safety:
event entity @a[r=10] spark:force_movement_on