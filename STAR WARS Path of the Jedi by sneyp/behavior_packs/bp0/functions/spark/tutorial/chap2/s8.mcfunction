# © Spark Universe, 2023
# authors: Arcaniax
# description: runs 20/s 
# called by: tutorial/loop

# YODA TALKING

# execute if score .timer tutorial matches 0 run event entity @e[type=spark:breadcrumb_1] spark:despawn
# execute if score .timer tutorial matches 0 run event entity @e[type=spark:breadcrumb_2] spark:despawn
# execute if score .timer tutorial matches 0 run event entity @e[type=spark:breadcrumb_3] spark:despawn
# execute if score .timer tutorial matches 0 run event entity @e[type=spark:breadcrumb_4] spark:despawn

# execute if score .timer tutorial matches 0 run gamemode adventure @a
# execute if score .timer tutorial matches 0 run tp @a 4.5 -26 3021.5 90 -30
execute as @e[type=spark:breadcrumb_4] at @s if entity @e[type=spark:kelleran_beq,r=3] run event entity @s spark:despawn
execute as @e[type=spark:breadcrumb_8] at @s if entity @e[type=spark:kelleran_beq,r=5] run event entity @s spark:despawn
execute as @e[type=spark:breadcrumb_12] at @s if entity @e[type=spark:kelleran_beq,r=5] run event entity @s spark:despawn
execute if score .timer tutorial matches 0 run playsound sound.spark.enter_ilum_temple @a
execute if score .timer tutorial matches 0 run music stop 2.0
execute if score .timer tutorial matches 0 run music play sound.spark.music.Reflection
execute if score .timer tutorial matches 0 run titleraw @a actionbar {"rawtext":[{ "text": "hud:location:" },{"translate":"spark.ui.location.jedi_temple", "with": [ "\n" ] }]}
execute if score .timer tutorial matches 0 positioned 0.5 -25.00 3021.5 run dialogue change @e[c=1,r=1,type=spark:yoda] spark:illum.yoda_1

execute as @e[type=spark:yoda] at @s run particle spark:npc_exclamation ~ ~1.75 ~

execute if score .timer tutorial matches 1.. if score .npc_trigger tutorial matches 1.. run function spark/tutorial/next