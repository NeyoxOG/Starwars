scoreboard players add .timer dueling_story 1

execute if score .state dueling_story matches 1 positioned 3315.5 51 0.5 run function spark/dueling/story/intro/before_elevator
execute if score .state dueling_story matches 2 positioned 8989 22 8975 run function spark/dueling/story/intro/after_elevator

execute if score .state dueling_story matches 3 as @a[tag=waiting,c=1] at @s run function spark/dueling/story/outro/wait
execute if score .state dueling_story matches 3 at @a run scoreboard players add @e[type=spark:duel_force_field,c=1] SS_const 0
# execute if score .state dueling_story matches 3 run function spark/dueling/story/intro/instance_setup
execute if score .state dueling_story matches 3 at @a run scoreboard players add @e[type=spark:duel_force_field,c=1,scores={SS_const=1..},r=50] dueling_story 1
execute if score .state dueling_story matches 3 at @a[tag=!waiting] as @e[type=spark:duel_force_field,c=1,scores={SS_const=1},r=50] at @s run function spark/dueling/cutscene/test
execute if score .state dueling_story matches 3 at @a[tag=!waiting] as @e[type=spark:duel_force_field,c=1,scores={SS_const=2},r=50] at @s run function spark/dueling/instance/loop
execute if score .state dueling_story matches 3 as @a[tag=!waiting] at @s as @e[type=spark:duel_force_field,c=1,scores={SS_const=3},r=50] at @s run function spark/dueling/story/outro/loss
execute if score .state dueling_story matches 3 as @a[tag=!waiting] at @s as @e[type=spark:duel_force_field,c=1,scores={SS_const=4},r=50] at @s run function spark/dueling/story/outro/win

execute if score .state dueling_story matches 4 positioned 8989 22 8975 run function spark/dueling/story/outro/loop

scoreboard players add .reset dueling_story 0
execute if score .reset dueling_story matches 0 if score .global dueling_rank matches 1.. if entity @a[x=8996.5,y=22.00,z=8975.62,r=2] run function spark/dueling/story/intro/setup_instances
execute if score .reset dueling_story matches 0 if score .global dueling_rank matches 1.. if entity @a[x=8996.5,y=22.00,z=8975.62,r=2] run scoreboard players set .reset dueling_story 1
execute if score .reset dueling_story matches 1 unless entity @a[x=8996.5,y=22.00,z=8975.62,r=2] run scoreboard players set .reset dueling_story 0

execute as @e[type=spark:duel_force_field,tag=enabled] at @s run function spark/dueling/story/intro/before_duel