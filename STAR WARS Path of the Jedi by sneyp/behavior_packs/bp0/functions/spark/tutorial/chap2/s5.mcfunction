# © Spark Universe, 2023
# authors: Arcaniax
# description: runs 20/s 
# called by: tutorial/loop

# WAIT FOR PLAYER TO EXIT THE MENU

#
execute if score .timer tutorial matches 9 positioned 94.5 -26.00 3026.5 run dialogue change @e[c=1,r=10,type=spark:kelleran_beq] spark:illum.kelleran_3
execute if score .timer tutorial matches 10 positioned 94.5 -26.00 3026.5 run dialogue open @e[type=spark:kelleran_beq,c=1] @a

execute if score .timer tutorial matches 0 run tp @a 99.5 -26 3019.5 55 0
execute if score .timer tutorial matches 0 run tp @e[type=spark:kelleran_beq,c=1] 96.5 -26 3021.5 -122.5 0

execute if score .timer tutorial matches 0 run gamemode 2 @a
execute if score .timer tutorial matches 5 run title @a actionbar hud:fade_in_1
# execute if score .timer tutorial matches 2 run event entity @e[type=spark:yoda] spark:despawn
# execute if score .timer tutorial matches 2 run summon spark:yoda 0.5 -24.00 3021.5 -90 0 "spark:quest_npc"
execute if score .timer tutorial matches 2 run tickingarea remove ilum_jedi_temple
execute if score .timer tutorial matches 3 positioned 0.5 -24.00 3021.5 as @e[c=1,r=5,type=spark:yoda] run event entity @s spark:enable_meditating
execute if score .timer tutorial matches 3 positioned 0.5 -24.00 3021.5 as @e[c=1,r=5,type=spark:yoda] run event entity @s spark:quest_npc_sitting
execute if score .timer tutorial matches 3 positioned 0.5 -24.00 3021.5 run dialogue change @e[c=1,r=5,type=spark:yoda] spark:illum.yoda_1
execute if score .timer tutorial matches 3 positioned 0.5 -24.00 3021.5 run event entity @e[c=1,r=5,type=spark:yoda] spark:disable_lightsaber

execute if score .timer tutorial matches 40.. if score .npc_trigger tutorial matches 1.. run function spark/tutorial/next
