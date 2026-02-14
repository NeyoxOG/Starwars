execute if score .timer dueling_story matches 1 run title @a actionbar hud:fade_out_1
execute if score .timer dueling_story matches 5 as @a at @s run playsound sound.spark.transitioner_fade_general @s
execute if score .timer dueling_story matches 22 run event entity @e[type=spark:kelleran_beq,c=1,r=10] spark:despawn
execute if score .timer dueling_story matches 25 run title @a actionbar hud:fade_in_1
execute if score .timer dueling_story matches 55 run scoreboard players set @a SS_ui_tutorial 20
execute if score .timer dueling_story matches 55 as @a at @s run playsound sound.spark.quest_minor @s

execute if score .timer dueling_story matches 55 run event entity @e[type=spark:elevator_button,tag=dueling] spark:unpressed

# execute positioned 3232 50 -13 as @a[dx=5,dy=20,dz=27] run say TODO: Maybe a message that reminds them that they can reach the dueling rooms with the elevators?
# execute positioned 3232 50 -13 as @a[dx=5,dy=20,dz=27] run tp @s 3270.5 51 0.5 0 0
