# © Spark Universe, 2023
# authors: William Savage
# description: runs 20/s 
# called by: chap3/s10 -> chap3/_iloop

# remove tag ti3warning

scoreboard objectives add tut_i_deflect dummy
scoreboard players add @s tut_i_deflect 0

# clear hud
execute if score @s tut_i_times matches 0 run titleraw @s actionbar {"rawtext":[{ "text": "hud:clear" }]}

# summon training dummies around the player while they are in the center
execute if score @s tut_i_times matches 3 as @s run summon spark:marksman_droid ~6 ~1.6 ~ 0 0 spark:track_and_attack_player
execute if score @s tut_i_times matches 4 as @s run summon spark:marksman_droid ~ ~1.6 ~6 0 0 spark:track_and_attack_player
execute if score @s tut_i_times matches 5 as @s run summon spark:marksman_droid ~-6 ~1.6 ~ 0 0 spark:track_and_attack_player

# set task 
execute if score @s tut_i_times matches 6 run scoreboard players set @s SS_ui_task 6
execute if score @s tut_i_times matches 6 run scoreboard players set @s SS_ui_tutorial 11

# calculate when to add a new bot
execute if score @s tut_i_times matches 6.. run scoreboard players set @s tut_i_bots 0
execute if score @s tut_i_times matches 6.. run execute as @e[type=spark:marksman_droid,r=20] run execute as @p[r=18] run scoreboard players add @s tut_i_bots 1

# if bot value is ..2, spawn a new bot until we have finished deflecting
# execute if score @s tut_i_times matches 6.. if score @s tut_i_bots matches ..2 run scoreboard players add @s tut_i_deflect 1
execute if score @s tut_i_times matches 6.. if score @s tut_i_bots matches ..2 run scoreboard players random .random tutorial 1 4
execute if score @s tut_i_times matches 6.. if score @s tut_i_bots matches ..2 if score .random tutorial matches 1 run summon spark:marksman_droid ~6 ~1.6 ~ facing @p spark:track_and_attack_player
execute if score @s tut_i_times matches 6.. if score @s tut_i_bots matches ..2 if score .random tutorial matches 2 run summon spark:marksman_droid ~-6 ~1.6 ~ facing @p spark:track_and_attack_player
execute if score @s tut_i_times matches 6.. if score @s tut_i_bots matches ..2 if score .random tutorial matches 3 run summon spark:marksman_droid ~ ~1.6 ~6 facing @p spark:track_and_attack_player
execute if score @s tut_i_times matches 6.. if score @s tut_i_bots matches ..2 if score .random tutorial matches 4 run summon spark:marksman_droid ~ ~1.6 ~-6 facing @p spark:track_and_attack_playerd

# play hint message about stamina once 
# execute if score @s tut_i_times matches 6.. if score @s tut_i_bots matches ..2 if entity @s[tag=!ti3warning] run titleraw @s actionbar {"rawtext":[{ "text": "hud:hint:" },{"translate":"spark.hint.training_droids.stamina", "with": [ "\n" ] }]}
execute if score @s tut_i_times matches 6.. if score @s tut_i_bots matches ..2 if entity @s[tag=!ti3warning] run tag @s add ti3warning

# we do not calculate on kills, but on deflects
# we detect if a projectile is a deflected one, and if it is, we assume deflect
# tag to not recount
# type_family = deflected
#execute if score @s tut_i_times matches 6.. if entity @e[r=20,type=spark:battle_droid_shot,family=deflected,tag=!counted] run scoreboard players add @s tut_i_deflect 1
#execute if score @s tut_i_times matches 6.. if entity @e[r=20,type=spark:battle_droid_shot,family=deflected,tag=!counted] run tag @e[r=20,type=spark:battle_droid_shot,family=deflected,tag=!counted] add counted 
# well done

#
effect @s resistance 10 10 true

#
execute if score @s tut_i_times matches 6.. run effect @e[r=18,type=spark:marksman_droid] resistance 999 10 true

execute if score @s tut_i_times matches 6.. if entity @e[r=20,type=spark:marksman_droid,family=hit_by_deflect,tag=!counted] run scoreboard players add @s tut_i_deflect 1
execute if score @s tut_i_times matches 6.. if entity @e[r=20,type=spark:marksman_droid,family=hit_by_deflect,tag=!counted] run tag @e[r=20,type=spark:battle_droid_shot,family=deflected,tag=!counted] add counted 
execute if score @s tut_i_times matches 6.. run kill @e[r=20,type=spark:marksman_droid,family=hit_by_deflect]

#execute if score @s tut_i_times matches 6.. if score @s tut_i_deflect matches 5 run titleraw @s actionbar {"rawtext":[{ "text": "hud:announce:" },{"translate":"intro.training_room.announcement.passed_tests.announcement1", "with": [ "\n" ] }]}
execute if score @s tut_i_times matches 6.. if score @s tut_i_deflect matches 5 run playsound sound.spark.success_minor @s

# currently we cannot calculate when a deflect has taken place, but we will simply count kills for now
execute if score @s tut_i_deflect matches 5 run function spark/tutorial/chap3/_inext
