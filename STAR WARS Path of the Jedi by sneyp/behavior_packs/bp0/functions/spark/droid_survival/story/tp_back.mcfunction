execute if score .timer droid_survival matches 1 run function spark/cutscene/start_ch02_c11


execute if score .timer droid_survival matches 1 as @a at @s run playsound sound.spark.cutscene_coruscant_arrival @s
# execute if score .timer droid_survival matches 1 run music stop 4.0
execute if score .timer droid_survival matches 1 run title @a title hud:kill_counter:


function spark/droid_survival/debug/clean_sidebar


execute if score .timer droid_survival matches 25 as @a at @s run playsound sound.spark.transitioner_fade_general @s
execute if score .timer droid_survival matches 41 run spawnpoint @a 3365 29 -115
execute if score .timer droid_survival matches 41 run time set 8000

execute if score .timer droid_survival matches 520 run function spark/achievement/trigger/droid_survival
execute if score .timer droid_survival matches 680 if score .highest_kills droid_survival >= .post_achievement droid_survival run function spark/achievement/trigger/droid_survival_post
execute if score .timer droid_survival matches 680 run scoreboard players set .state droid_survival -1
execute if score .timer droid_survival matches 680 run scoreboard players set .timer droid_survival 0