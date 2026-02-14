#If one teleported from the temple, it saves which elevator in the temple one came from
execute as @a[tag=elevator_tp] run function spark/tutorial/elevator/save_current_elevator

#Spread players when more than one teleport
spreadplayers 9000 9006 1 2 @a[tag=elevator_tp,tag=elevator_spread]
execute as @a[tag=elevator_tp,tag=elevator_spread] at @s run tp @s ~ 22 ~ -180 ~

#Else tp to fixed location
tp @a[tag=elevator_tp,tag=!elevator_spread] 9000 22 9005 -180 ~

execute positioned 9000 22 9005 run event entity @e[type=spark:elevator_button,r=10,tag=!dueling] spark:unpressed
execute positioned 9000 22 9005 run event entity @e[type=spark:elevator_button,r=10,tag=dueling] spark:disable

#Tutorial stuff
execute if score .state dueling_story matches 1 run scoreboard players set .timer dueling_story 0
execute if score .state dueling_story matches 1 run tp @a 9000 22 8995 -180 ~
execute unless score .state dueling_story matches 1 run titleraw @a[tag=elevator_tp] actionbar {"rawtext":[{"text":"hud:hint:"},{"translate":"lightsaber_dueling.tip.play_again.tip1"}]}
execute if score .state dueling_story matches 1 run scoreboard players set .state dueling_story 2
# execute if score .state dueling_story matches 1 run titleraw @a actionbar {"rawtext":[{"text":"hud:hint:"},{"translate":"lightsaber_dueling.tip.play_again.tip1"}]}
titleraw @a[x=9000,y=22,z=9005,r=50,tag=elevator_tp] title {"rawtext":[{ "text": "hud:elevator:" }]}