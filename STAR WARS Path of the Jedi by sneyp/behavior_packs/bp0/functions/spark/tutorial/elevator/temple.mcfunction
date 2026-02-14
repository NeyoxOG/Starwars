#elevator_tp = people that were in the elevator a second ago
#elevator_spread = several people in elevator, so spread them

#Fallback
execute as @a[tag=elevator_tp] at @s unless score @s elevator matches 1..4 run tp @s 3270 51 -13 0 ~
execute as @a[tag=elevator_tp] at @s unless score @s elevator matches 1..4 positioned 3270 51 -13 run event entity @e[type=spark:elevator_button,r=10,tag=!temple] spark:unpressed
execute as @a[tag=elevator_tp] at @s unless score @s elevator matches 1..4 positioned 3270 51 -13 run event entity @e[type=spark:elevator_button,r=10,tag=temple] spark:disable

#Spread players when more than one teleport
spreadplayers 3270 -13 1 2 @a[tag=elevator_tp,tag=elevator_spread,scores={elevator=1}]
execute as @a[tag=elevator_tp,tag=elevator_spread,scores={elevator=1}] at @s run tp @s ~ 51 ~ 0 ~

spreadplayers 3270 13 1 2 @a[tag=elevator_tp,tag=elevator_spread,scores={elevator=2}]
execute as @a[tag=elevator_tp,tag=elevator_spread,scores={elevator=2}] at @s run tp @s ~ 51 ~ 180 ~

spreadplayers 3389 103 1 2 @a[tag=elevator_tp,tag=elevator_spread,scores={elevator=3}]
execute as @a[tag=elevator_tp,tag=elevator_spread,scores={elevator=3}] at @s run tp @s ~ 34 ~ 180 ~

spreadplayers 3389 -103 1 2 @a[tag=elevator_tp,tag=elevator_spread,scores={elevator=4}]
execute as @a[tag=elevator_tp,tag=elevator_spread,scores={elevator=4}] at @s run tp @s ~ 34 ~ 0 ~

#Else tp to fixed location
execute as @a[tag=elevator_tp,tag=!elevator_spread,scores={elevator=1}] at @s run tp @s 3270 51 -13 0 ~
execute as @a[tag=elevator_tp,tag=!elevator_spread,scores={elevator=2}] at @s run tp @s 3270 51 13 180 ~
execute as @a[tag=elevator_tp,tag=!elevator_spread,scores={elevator=3}] at @s run tp @s 3389 34 103 180 ~
execute as @a[tag=elevator_tp,tag=!elevator_spread,scores={elevator=4}] at @s run tp @s 3389 34 -103 0 ~


#Set buttons active etc.
execute if entity @a[scores={elevator=1}] positioned 3270 51 -13 run event entity @e[type=spark:elevator_button,r=10,tag=!temple] spark:unpressed
execute if entity @a[scores={elevator=1}] positioned 3270 51 -13 run event entity @e[type=spark:elevator_button,r=10,tag=temple] spark:disable

execute if entity @a[scores={elevator=2}] positioned 3270 51 13 run event entity @e[type=spark:elevator_button,r=10,tag=!temple] spark:unpressed
execute if entity @a[scores={elevator=2}] positioned 3270 51 13 run event entity @e[type=spark:elevator_button,r=10,tag=temple] spark:disable

execute if entity @a[scores={elevator=3}] positioned 3389 34 103 run event entity @e[type=spark:elevator_button,r=10,tag=!temple] spark:unpressed
execute if entity @a[scores={elevator=3}] positioned 3389 34 103 run event entity @e[type=spark:elevator_button,r=10,tag=temple] spark:disable

execute if entity @a[scores={elevator=4}] positioned 3389 34 -103 run event entity @e[type=spark:elevator_button,r=10,tag=!temple] spark:unpressed
execute if entity @a[scores={elevator=4}] positioned 3389 34 -103 run event entity @e[type=spark:elevator_button,r=10,tag=temple] spark:disable

#Tutorial stuff
execute as @a[tag=elevator_tp] run function spark/tutorial/chap4/quest_giver_task
execute if score .substate tutorial matches 5 if score .state tutorial matches 4 run function spark/tutorial/chap4/teleported_to_temple