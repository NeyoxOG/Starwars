execute if score .timer droid_survival matches 1 run title @a actionbar hud:fade_out_1
execute if score .timer droid_survival matches 21 run spreadplayers 9000 0 1 5 @a
execute if score .timer droid_survival matches 21 run title @a actionbar hud:fade_in_1
# execute if score .timer droid_survival matches 21 as @a at @s run playsound sound.spark.transitioner_kamino_outdoors @s
execute if score .timer droid_survival matches 38 positioned 9000 100 0 run event entity @e[family=raider] spark:despawn
#execute if score .timer droid_survival matches 40 positioned 9000 100 0 run event entity @e[type=spark:box,r=200] spark:despawn
#execute if score .timer droid_survival matches 40 positioned 9000 100 0 run function spark/droid_survival/debug/respawn_boxes
#execute if score .timer droid_survival matches 42 positioned 9000 100 0 run event entity @e[type=spark:box,r=200] spark:texture_1

execute if score .timer droid_survival matches 41 run titleraw @a actionbar {"rawtext":[{ "text": "hud:location:" },{"translate":"droid_survival.location_banner.kamino_exterior.location1", "with": [ "\n" ] }]}
execute if score .timer droid_survival matches 41 as @a at @s run playsound sound.spark.raid_start @s
#execute if score .timer droid_survival matches 41 as @a at @s run scoreboard players set @a SS_ui_task 10 
#execute if score .timer droid_survival matches 100 run scoreboard objectives setdisplay sidebar droid_survival_stats
execute if score .timer droid_survival matches 80 run function spark/droid_survival/next_wave
execute if score .timer droid_survival matches 80 positioned 9000 100 0 run function spark/droid_survival/powerups/spawn
execute if score .timer droid_survival matches 80 run scoreboard players set .timer droid_survival 98