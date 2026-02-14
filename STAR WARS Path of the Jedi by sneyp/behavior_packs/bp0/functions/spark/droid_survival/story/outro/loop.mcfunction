execute if score .timer droid_survival matches 0 run function spark/cutscene/start_ch09_c02
execute if score .timer droid_survival matches 0 run title @a title hud:kill_counter:

execute if score .timer droid_survival matches 470 run effect @a instant_health 10 10 true
execute if score .timer droid_survival matches 500 run title @a title hud:kill_counter:
execute if score .timer droid_survival matches 500 run scoreboard players set @a SS_ui_task 0

execute if score .timer droid_survival matches 500 at @p run tp @e[type=spark:astromech,r=50] ^ ^ ^-1 
execute if score .timer droid_survival matches 500 run title @a[tag=!dev] actionbar hud:fade_in_1
execute if score .timer droid_survival matches 520 as @a at @s run playsound sound.spark.transitioner_kamino_indoors @s
execute if score .timer droid_survival matches 520 as @a at @s run music stop 1.0

execute if score .timer droid_survival matches 520 run function spark/droid_survival/story/outro/show_score
execute if score .timer droid_survival matches 535 run event entity @e[type=spark:nala_se,c=1] spark:quest_npc
execute if score .timer droid_survival matches 540 run dialogue change @e[type=spark:nala_se,c=1] spark:droid_battle.nala.1
execute if score .timer droid_survival matches 540 run tag @e[type=spark:nala_se,c=1] add very_tall
execute if score .timer droid_survival matches 540 run tag @e[type=spark:nala_se,c=1] add has_quest

scoreboard players add @e[type=spark:holo_mace_windu,tag=has_quest] timer 1
execute as @e[type=spark:holo_mace_windu,tag=has_quest,scores={timer=5},c=1] run event entity @s spark:quest_npc
execute as @e[type=spark:holo_mace_windu,tag=has_quest,scores={timer=7},c=1] run dialogue change @e[type=spark:holo_mace_windu,c=1] spark:droid_battle.mace.1