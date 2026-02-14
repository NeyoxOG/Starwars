# © Spark Universe, 2023
# authors: Jannis
# description: Player loses
# called by: 
# executor: duel_force_field

playsound sound.spark.duel_loss @a[r=50]
function spark/dueling/instance/disable_shield
scoreboard players set @s SS_const 3
scoreboard players set @s dueling_story 0
# tag @a[r=50] add waiting
# titleraw @a[r=50] actionbar {"rawtext":[{ "text": "hud:announce:" },{"translate":"lightsaber_dueling.announcement.lost.announcement1", "with": {"rawtext": [ { "selector": "@e[family=duel_opponent,tag=!sitting,c=1]" }] } }]}