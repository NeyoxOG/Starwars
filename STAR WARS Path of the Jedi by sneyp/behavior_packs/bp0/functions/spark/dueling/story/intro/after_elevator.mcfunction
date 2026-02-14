execute if score .timer dueling_story matches 1 run scoreboard players set @a SS_ui_tutorial 0
execute if score .timer dueling_story matches 1 run scoreboard players set @a SS_ui_task 0
# execute if score .timer dueling_story matches 1 run title @a actionbar hud:fade_out_1

# # execute if score .timer dueling_story matches 21 run function spark/dueling/instance/setup_entities
# # execute if score .timer dueling_story matches 21 run summon spark:kelleran_beq 9000.5 22 8990.5 0 0 spark:quest_npc
# # execute if score .timer dueling_story matches 21 run summon spark:duel_leaderboard 9008.50 23.00 8992.50
# # execute if score .timer dueling_story matches 21 run summon spark:elevator_door 9000.5 22.00 8999.5
# # execute if score .timer dueling_story matches 22 as @e[type=spark:duel_leaderboard] run function spark/dueling/update_leaderboard
# # execute if score .timer dueling_story matches 22 run tag @e[type=spark:kelleran_beq,c=1] add has_quest
# # execute if score .timer dueling_story matches 22 run dialogue change @e[type=spark:kelleran_beq,c=1] spark:lightsaber_dueling.npc.kelleran.duel_explanation.1
# # execute if score .timer dueling_story matches 22 run dialogue change @e[type=spark:kelleran_beq,c=1] spark:lightsaber_dueling.npc.kelleran.duel_explanation.1 @a


# execute if score .timer dueling_story matches 20 run tp @a 9000 22.00 8995 -180 0
# # 																												 9000 22.00 9005 -180 ~
# execute if score .timer dueling_story matches 21 run title @a actionbar hud:fade_in_1

#continues via npc interaction