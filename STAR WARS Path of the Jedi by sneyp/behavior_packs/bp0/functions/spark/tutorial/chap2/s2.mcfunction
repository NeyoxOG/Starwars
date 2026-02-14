# © Spark Universe, 2023
# authors: Arcaniax
# description: runs 20/s 
# called by: tutorial/loop

# ILLUM WALK UP TO ENTRANCE

# execute if score .timer tutorial matches 0 run tp @a 142.5 -25.00 3001.5 69 0
execute if score .timer tutorial matches 0 run particle spark:ilum_blizzard_instant 142.5 -25.00 3001.5
execute if score .timer tutorial matches 0 run gamemode adventure @a
execute if score .timer tutorial matches 1 run playsound sound.spark.transitioner_front_of_ship @a

# execute if score .timer tutorial matches 1 run event entity @e[type=spark:padawan_1] spark:despawn
# execute if score .timer tutorial matches 1 run event entity @e[type=spark:padawan_2] spark:despawn
# execute if score .timer tutorial matches 1 run event entity @e[type=spark:padawan_3] spark:despawn
# execute if score .timer tutorial matches 1 run event entity @e[type=spark:kelleran_beq] spark:despawn
# execute if score .timer tutorial matches 1 run summon spark:padawan_3 95.35 -26.00 3030.77 facing 94.5 -24.50 3026.5
# execute if score .timer tutorial matches 1 run summon spark:padawan_2 99.53 -26.00 3027.86 facing 94.5 -24.50 3026.5
# execute if score .timer tutorial matches 1 run summon spark:padawan_1 97.95 -26.00 3029.24 facing 94.5 -24.50 3026.5
# execute if score .timer tutorial matches 1 run summon spark:kelleran_beq 94.5 -26.00 3026.5 facing @p "spark:quest_npc"
# execute if score .timer tutorial matches 2 positioned 94.5 -26.00 3026.5 run dialogue change @e[c=1,r=1,type=spark:kelleran_beq] spark:illum.kelleran_1


execute if score .timer tutorial matches 50 run titleraw @a actionbar {"rawtext":[{ "text": "hud:location:" },{"translate":"intro.ilum.location_banner.location1", "with": [ "\n" ] }]}



execute if score .timer tutorial matches 50.. if score .npc_trigger tutorial matches 1.. run function spark/tutorial/next

execute as @e[type=spark:kelleran_beq] at @s run particle spark:npc_exclamation ~ ~2.5 ~