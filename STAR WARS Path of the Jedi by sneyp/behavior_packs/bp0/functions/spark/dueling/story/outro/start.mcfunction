scoreboard players set .state dueling_story 4
scoreboard players set .timer dueling_story 0
tag @a remove waiting
execute as @a at @s run playsound sound.spark.success_major @s
tag @e[type=spark:kelleran_beq,c=1] add has_quest
execute if entity @a[tag=duel_win] run scoreboard players set @a SS_ui_task 0
execute if entity @a[tag=duel_win] run dialogue change @e[type=spark:kelleran_beq,c=1] spark:lightsaber_dueling.npc.kelleran.win
execute unless entity @a[tag=duel_win] run dialogue change @e[type=spark:kelleran_beq,c=1] spark:lightsaber_dueling.npc.kelleran.lose