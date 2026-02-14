function spark/droid_survival/enemy_flee

# need a custom color here!
execute if score .wave droid_survival matches 1.. run titleraw @a actionbar {"rawtext":[{ "text": "hud:announce:§6" },{"translate":"droid_survival.announcement.waves_score", "with": {"rawtext":[{"score":{"name":".wave","objective":"droid_survival"}}]} }]}
playsound sound.spark.raid_cleared @a

scoreboard players add .wave droid_survival 1
scoreboard players set .timer droid_survival 0
scoreboard players set .ambush_timer droid_survival 0

scoreboard players operation Wave droid_survival_stats = .wave droid_survival

execute positioned 9000 100 0 run function spark/droid_survival/powerups/spawn

spreadplayers 9000 0 1 5 @a[m=spectator,tag=in_droid_survival]
gamemode adventure @a[m=spectator,tag=in_droid_survival]
