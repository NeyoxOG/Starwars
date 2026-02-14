execute if score .timer dueling_story matches 21 run function spark/dueling/setup_instances

execute if score .timer dueling_story matches 41 run scoreboard players set @a SS_ui_task 20
execute if score .timer dueling_story matches 41 run scoreboard players set @e[type=spark:duel_force_field] SS_const 0
execute if score .timer dueling_story matches 41.. at @a[tag=!waiting] as @e[type=spark:duel_force_field,c=1,scores={SS_const=0}] at @s run function spark/dueling/story/intro/before_duel