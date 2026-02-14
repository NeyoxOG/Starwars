# © Spark Universe, 2022
# authors: dragonmaster95
# description: Controller for waves 1-10
# called by: ../main

scoreboard players add .wave droid_survival 0

execute if score .wave droid_survival matches 0 run function spark/droid_survival/waves/intro

#Start next wave if current wave finished/only some leftover mobs
execute if score .wave droid_survival matches 1 if score .timer droid_survival matches 100.. if score Droids_Defeated droid_survival_stats matches 1.. run titleraw @a title {"rawtext":[{ "text": "hud:kill_counter:§x" },{ "score": {"name": "Droids_Defeated", "objective": "droid_survival_stats" }}]}
execute if score .wave droid_survival matches 1.. if score .timer droid_survival matches 100 run scoreboard players set .timer2 droid_survival 0    
execute if score .wave droid_survival matches 1.. if score .timer droid_survival matches 100 run scoreboard players set .amount2 droid_survival 1
execute if score .wave droid_survival matches 2 if score .timer droid_survival matches 50 run titleraw @a actionbar {"rawtext":[{ "text": "hud:hint:" },{"translate":"droid_survival.hint.powerups", "with": [ "\n" ] }]}
execute if score .wave droid_survival matches 1.. if score .timer droid_survival matches 100.. if score .amount2 droid_survival matches 1.. run function spark/droid_survival/waves/summon
execute if score .wave droid_survival matches 1.. if score .timer droid_survival matches 500.. if score .amount2 droid_survival matches ..0 run function spark/droid_survival/check_finished_wave


execute if score .wave droid_survival matches 1.. if score .timer droid_survival matches ..1 run scoreboard players set @a[tag=in_droid_survival] SS_ui_task 10
execute if score .wave droid_survival matches 1 if score .timer droid_survival matches 140 run titleraw @a actionbar {"rawtext":[{ "text": "hud:announce:§c" },{"translate":"droid_survival.kamino_exterior.announcement.defeat_droids", "with": [ "\n" ] }]}


execute if score .wave droid_survival matches 1.. run scoreboard players set .temp droid_survival 0
execute if score .wave droid_survival matches 1.. run playsound sound.spark.quest_major @s
# execute if score .wave droid_survival matches 1.. run music stop 2.0 
# execute if score .wave droid_survival matches 1.. run music play sound.spark.music_jango_escape 1.0 0.1 loop
execute if entity @a if score .wave droid_survival matches 1.. as @a[tag=in_droid_survival,m=!spectator] run scoreboard players add .temp droid_survival 1
execute if entity @a if score .wave droid_survival matches 1.. if score .timer droid_survival matches 10.. if score .temp droid_survival matches ..0 run function spark/droid_survival/waves/end