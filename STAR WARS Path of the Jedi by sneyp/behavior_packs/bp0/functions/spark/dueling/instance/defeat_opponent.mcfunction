# © Spark Universe, 2023
# authors: Jannis
# description: Runs when defeating the enemy, before actually triggering the win
# called by: 
# executor: duel_force_field


titleraw @a[r=50] actionbar {"rawtext":[{ "text": "hud:announce:" },{"translate":"lightsaber_dueling.announcement.opponent_defeated.announcement1", "with": { "rawtext": [{ "selector": "@s" }]}}]}
playsound sound.spark.success_medium @a[r=50] ~ ~ ~ 100

