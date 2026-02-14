# © Spark Universe, 2023
# authors: William Savage
# description: runs 20/s 
# called by: chap3/loop

# CURCIBLE INTRO

execute if score .timer tutorial matches 20 run music stop 5.0
# execute if score .timer tutorial matches 20 run playsound sound.spark.cutscene_leaving_ilum @a


execute if score .timer tutorial matches 20 run function spark/cutscene/start_ch02_c06


execute if score .timer tutorial matches 275 run scoreboard objectives add chap3_tmp dummy
execute if score .timer tutorial matches 275 run scoreboard players set .s2 chap3_tmp 0
execute if score .timer tutorial matches 275 run function spark/tutorial/next
