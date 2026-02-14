#If one teleported from the temple, it saves which elevator in the temple one came from
execute as @a[tag=elevator_tp] run function spark/tutorial/elevator/save_current_elevator

#Spread players when more than one teleport
spreadplayers 8838.5 8929.5 1 2 @a[tag=elevator_tp,tag=elevator_spread]
execute as @a[tag=elevator_tp,tag=elevator_spread] at @s run tp @s ~ 27 ~ 180 ~

#Else tp to fixed location
tp @a[tag=elevator_tp,tag=!elevator_spread] 8838.5 27 8929.5 -90 ~

execute positioned 8838.5 27 8929.5 run event entity @e[type=spark:elevator_button,r=10,tag=!crafting] spark:unpressed
execute positioned 8838.5 27 8929.5 run event entity @e[type=spark:elevator_button,r=10,tag=crafting] spark:disable