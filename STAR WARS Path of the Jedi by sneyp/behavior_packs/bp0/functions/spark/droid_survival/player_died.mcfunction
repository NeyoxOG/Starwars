tp @s 9000 136 16 facing 9000 100 0
gamemode spectator @s

music stop 10.0
music play sound.spark.ambience_kamino
playsound sound.spark.kamino_player_defeated @s
scoreboard players set .tmp droid_survival 0
execute as @a[tag=in_droid_survival,m=!spectator] run scoreboard players add .tmp droid_survival 1

# if .tmp = ..0 add the special tag
execute if score .tmp droid_survival matches 0 run tag @s add no_script_fade

execute if score .tmp droid_survival matches 0 run function spark/droid_survival/waves/end
# execute if score .tmp droid_survival matches 0 run function spark/droid_survival/end


scoreboard players set @s SS_ui_task 0
tag @s remove death_can_respawn
tag @s remove dead