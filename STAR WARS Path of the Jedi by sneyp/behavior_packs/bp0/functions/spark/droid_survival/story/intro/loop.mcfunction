# execute if score .timer droid_survival matches 20 run say TODO: Play cutscene ch09_c01
# execute if score .timer droid_survival matches 20 as @a at @s run playsound sound.spark.cutscene_kamino_arrival @s

execute if score .timer droid_survival matches 20 run function spark/cutscene/start_ch09_c01

execute if score .timer droid_survival matches 20 run scoreboard players set @a SS_ui_tutorial 0
execute if score .timer droid_survival matches 20 run scoreboard players set @a SS_ui_task 0
#fallback tp
execute if score .timer droid_survival matches 740 run tp @a ~~~ 180 0

execute if score .timer droid_survival matches 640..795 run scoreboard players set @a SS_ui_tutorial 0
execute if score .timer droid_survival matches 640..795 run scoreboard players set @a SS_ui_task 0
execute if score .timer droid_survival matches 772 run time set 5000
execute if score .timer droid_survival matches 775 run dialogue change @e[type=spark:shaak_ti,c=1] spark:droid_battle.shaak_ti.1
execute if score .timer droid_survival matches 775 run tag @e[type=spark:shaak_ti,c=1] add tall
execute if score .timer droid_survival matches 775 run tag @e[type=spark:shaak_ti,c=1] add has_quest

execute if score .timer droid_survival matches 795 run music stop 3.0
execute if score .timer droid_survival matches 795 as @a at @s run playsound sound.spark.transitioner_kamino_indoors @s

execute if score .timer droid_survival matches 795 run titleraw @a actionbar {"rawtext":[{ "text": "hud:location:" },{"translate":"droid_survival.location_banner.kamino_interior.location1", "with": [ "\n" ] }]}
# execute if score .timer droid_survival matches 795 as @a at @s run playsound sound.spark.raid_start @s
