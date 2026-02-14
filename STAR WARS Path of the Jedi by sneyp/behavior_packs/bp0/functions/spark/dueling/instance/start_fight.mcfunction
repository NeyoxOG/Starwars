# © Spark Universe, 2023
# authors: Jannis
# description: After the intro cutscene, begin the actual fight
# called by: 
# executor: duel_force_field

# TODO: TRANSLATE THIS
titleraw @a[r=50] actionbar {"rawtext":[{ "text": "hud:announce:" },{"translate":"Fight!", "with": [ "\n" ] }]}
clear @a[r=50] spark:push 1 0
clear @a[r=50] spark:pull 1 0
clear @a[r=50] spark:grab 1 0
clear @a[r=50] spark:insight 1 0
music play sound.spark.music.TheArrival 1.0 0.1 loop

event entity @e[family=duel_opponent,tag=!sitting,r=30] start_dueling

inputpermission set @a[r=50] movement enabled
inputpermission set @a[r=50] camera enabled
gamemode adventure @a[r=50]

camera @a[r=50] clear
# event entity @a[r=50] spark:force_movement_off
# tp @a[r=50] ~8 ~ ~ 90 10
#(in case this is ran outside of the intended function)
scoreboard players set .state dueling_story 3
scoreboard players set @s SS_const 2