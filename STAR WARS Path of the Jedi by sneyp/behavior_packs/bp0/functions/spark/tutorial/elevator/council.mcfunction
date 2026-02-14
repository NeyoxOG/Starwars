#If one teleported from the temple, it saves which elevator in the temple one came from
execute as @a[tag=elevator_tp] run function spark/tutorial/elevator/save_current_elevator

#Spread players when more than one teleport
spreadplayers 9200 9006 1 2 @a[tag=elevator_tp,tag=elevator_spread]
execute as @a[tag=elevator_tp,tag=elevator_spread] at @s run tp @s ~ 37 ~ 180 ~

#Else tp to fixed location
tp @a[tag=elevator_tp,tag=!elevator_spread] 9200 37 9006 180 ~

execute positioned 9200 37 9006 run event entity @e[type=spark:elevator_button,r=10,tag=!council] spark:unpressed
execute positioned 9200 37 9006 run event entity @e[type=spark:elevator_button,r=10,tag=council] spark:disable

#Tutorial stuff
execute if score .substate tutorial matches 3 if score .state tutorial matches 4 run function spark/tutorial/next_chapter