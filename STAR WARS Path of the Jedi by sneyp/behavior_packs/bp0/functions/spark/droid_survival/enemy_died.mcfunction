scoreboard players add Droids_Defeated droid_survival_stats 1
titleraw @a title {"rawtext":[{ "text": "hud:kill_counter:§x" },{ "score": {"name": "Droids_Defeated", "objective": "droid_survival_stats" }}]}
scoreboard players operation .tmp droid_survival = Remaining droid_survival_stats
execute if score .tmp droid_survival matches 1.. run scoreboard players remove .tmp droid_survival 1
execute if score .tmp droid_survival matches ..-1 run scoreboard players set .tmp droid_survival 0
scoreboard players operation Remaining droid_survival_stats = .tmp droid_survival
playsound sound.spark.kill_counter_up