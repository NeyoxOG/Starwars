# © Spark Universe, 2023
# authors: Arcaniax
# description: runs 20/s 
# called by: tutorial/loop

# ILLUM INTRO


execute if score .timer tutorial matches 40 run function spark/cutscene/start_ch02_c01



execute if score .timer tutorial matches 40 run time set 11500

execute if score .timer tutorial matches 690 run replaceitem entity @a slot.armor.chest 0 spark:cloak_default 1 0 {"item_lock": { "mode": "lock_in_slot" }}

# execute if score .timer tutorial matches 20 run music play sound.spark.music_naboo_arrival 
execute if score .timer tutorial matches 695 run playsound sound.spark.cutscene_ilum_arrival @a

execute if score .timer tutorial matches 690 run particle spark:ilum_blizzard_instant 120.94 -4.79 3027.17

execute if score .timer tutorial matches 690 run function spark/tutorial/next