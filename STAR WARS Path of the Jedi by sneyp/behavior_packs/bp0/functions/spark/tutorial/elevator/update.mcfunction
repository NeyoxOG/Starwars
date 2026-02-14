
#Before starting quest
execute if score .state dueling_story matches 0 at @a run event entity @e[type=spark:elevator_button,r=16,tag=dueling] spark:disable
execute if score .state dueling_story matches 1 if score .timer dueling_story matches ..54 at @a run event entity @e[type=spark:elevator_button,r=16,tag=dueling] spark:disable
#After accepting quest
execute if score .state dueling_story matches 1 if score .timer dueling_story matches 55.. at @a run function spark/tutorial/elevator/lobby_buttons_dueling

execute at @a run tag @e[type=spark:elevator_button,r=16,tag=archives] remove dueling
execute at @a run tag @e[type=spark:elevator_button,r=16,tag=archives] remove temple
execute at @a run tag @e[type=spark:elevator_button,r=16,tag=archives] remove crafting
execute at @a run tag @e[type=spark:elevator_button,r=16,tag=archives] remove council

#After starting quest
execute if score .state dueling_story matches 2.. at @a run function spark/tutorial/elevator/lobby_buttons_normal
execute if score .state dueling_story matches 2.. at @a as @e[type=spark:elevator_button,r=16,tag=dueling] unless entity @s[x=9000,y=22,z=9008,r=32] run event entity @s spark:unpressed