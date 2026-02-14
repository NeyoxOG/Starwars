event entity @e[family=raider] spark:despawn
event entity @e[type=spark:marker,tag=droid_survival] spark:despawn

# music stop 3.0 
# music play sound.spark.ambience_kamino 1.0 0.1 loop
scoreboard players set @a SS_ui_task 0 


#spreadplayers 9000 0 1 5 @a
gamemode adventure @a

scoreboard players set .state droid_survival 3
scoreboard players set .timer droid_survival 0
scoreboard players set .wave droid_survival 0
scoreboard players set .tmp droid_survival 0

tag @a remove in_droid_survival
playsound sound.spark.raid_cleared @a ~~~
scoreboard objectives setdisplay sidebar

# title @a actionbar hud:fade_out_1
# titleraw @a actionbar {"rawtext":[{ "text": "hud:announce:" },{"translate":"droid_survival.kamino_exterior.announcement.faint.announcement1", "with": [ "\n" ] }]}