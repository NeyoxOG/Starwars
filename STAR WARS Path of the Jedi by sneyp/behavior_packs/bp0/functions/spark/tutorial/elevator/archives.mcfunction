#If one teleported from the temple, it saves which elevator in the temple one came from
execute as @a[tag=elevator_tp] run function spark/tutorial/elevator/save_current_elevator

#Spread players when more than one teleport
spreadplayers 9011.5 9159.5 1 2 @a[tag=elevator_tp,tag=elevator_spread]
execute as @a[tag=elevator_tp,tag=elevator_spread] at @s run tp @s ~ 26 ~ 90 ~

#Else tp to fixed location
tp @a[tag=elevator_tp,tag=!elevator_spread] 9011.5 26 9159.5 90 ~

execute positioned 9011.5 26 9159.5 run event entity @e[type=spark:elevator_button,r=10,tag=!archives] spark:unpressed
execute positioned 9011.5 26 9159.5 run event entity @e[type=spark:elevator_button,r=10,tag=archives] spark:disable