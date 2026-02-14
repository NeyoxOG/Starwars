# © Spark Universe, 2023
# authors: Arcaniax
# description: runs 20/s 
# called by: chap1/loop


# getting skipped now

# CRUCIBLE
execute if score .timer tutorial matches 0 run tp @a 3047.5 -49.0 2962.5 180 5
execute if score .timer tutorial matches 30 positioned 3047.5 -49.00 2958.5 run event entity @e[type=spark:kelleran_beq,r=10] spark:despawn
execute if score .timer tutorial matches 30 run summon spark:kelleran_beq 3047.5 -49.0 2959.0 0 0 "spark:quest_npc"
execute if score .timer tutorial matches 30 run summon spark:ad_3 3046.5 -49 2956.5 -180 0 "spark:quest_npc"
execute if score .timer tutorial matches 30 run summon spark:lx_r5_droid 3046.0 -49.0 2959.0 0 0 "spark:quest_npc"
execute if score .timer tutorial matches 31 positioned 3047.5 -49.0 2959.0 run dialogue change @e[c=1,r=10,type=spark:kelleran_beq] spark:crucible.kelleran_1
execute if score .timer tutorial matches 31 positioned 3046.5 -49.0 2956.5 run dialogue change @e[c=1,r=10,type=spark:ad_3] spark:crucible.ad_3
execute if score .timer tutorial matches 31 positioned 3046.0 -49.0 2959.0 run dialogue change @e[c=1,r=10,type=spark:lx_r5_droid] spark:crucible.lx_r5_droid

execute as @e[type=spark:kelleran_beq] at @s run particle spark:npc_exclamation ~ ~2.5 ~

execute if score .timer tutorial matches 100 run playsound sound.spark.transitioner_cockpit 

execute if score .timer tutorial matches 100 run titleraw @a actionbar {"rawtext":[{ "text": "hud:location:" },{"translate":"intro.location_banner.crucible", "with": [ "\n" ] }]}

execute if score .timer tutorial matches 120.. if score .npc_trigger tutorial matches 1.. run function spark/tutorial/next_chapter

# TODO add hyperspace sequence