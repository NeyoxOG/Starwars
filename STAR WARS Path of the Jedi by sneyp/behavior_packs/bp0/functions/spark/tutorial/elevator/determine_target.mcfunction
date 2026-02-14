#Determines where to teleport to based on the score of the button
tag @a[r=30,tag=elevator_tmp] add elevator_tp
tag @a[r=30,tag=elevator_tp] remove elevator_tmp
title @a[r=30,tag=elevator_tp] actionbar hud:fade_in_1

# clear the stand in cirlce tutorial message
scoreboard players set @a SS_ui_tutorial 0
scoreboard players set @a SS_ui_task 0
# clear the elevator button hover
titleraw @a[r=10,tag=elevator_tp] title {"rawtext":[{ "text": "hud:elevator:" }]}

execute if score @s elevator matches 3 run function spark/tutorial/elevator/council
execute if score @s elevator matches 2 run function spark/tutorial/elevator/dueling
execute if score @s elevator matches 1 run function spark/tutorial/elevator/crafting
execute if score @s elevator matches 0 run function spark/tutorial/elevator/temple
execute if score @s elevator matches -1 run function spark/tutorial/elevator/archives

execute as @a[tag=elevator_tp] at @s run playsound sound.spark.cutscene_elevator @s
titleraw @a[tag=elevator_tp] title {"rawtext":[{ "text": "hud:elevator:" }]}

tag @a[tag=elevator_tp] remove elevator_spread
tag @a remove elevator_tp

# tickingarea remove spark.elevator.current
# tickingarea remove spark.elevator.target