# © Spark Universe, 2023
# authors: Arcaniax
# description: runs 20/s 
# called by: tutorial/loop

# YODA CUTSCENE OPENING UP ILUM CAVES

execute if score .timer tutorial matches 0 run function spark/cutscene/start_ch02_c04
execute if score .timer tutorial matches 0 positioned 0.5 -25.00 3021.5 run event entity @e[type=spark:yoda,c=1,r=1] spark:reset_npc
execute if score .timer tutorial matches 3 positioned 0.5 -25.00 3021.5 run event entity @e[type=spark:yoda,c=1,r=1] spark:quest_npc
execute if score .timer tutorial matches 5 positioned 0.5 -25.00 3021.5 run dialogue change @e[c=1,r=1,type=spark:yoda] spark:illum.yoda_3
execute if score .timer tutorial matches 1 run scoreboard players add .ice_path tutorial 0
execute if score .timer tutorial matches 1 if score .ice_path tutorial matches 0 run scoreboard players random .ice_path tutorial 1 3

execute if score .timer tutorial matches 100 if score .ice_path tutorial matches 1 positioned -197 -31 3071 run tickingarea add ~ ~ ~ ~21 ~25 ~26 pathway_temp true 
execute if score .timer tutorial matches 100 if score .ice_path tutorial matches 2 positioned -231 -29 3046 run tickingarea add ~ ~ ~ ~14 ~14 ~14 pathway_temp true
execute if score .timer tutorial matches 100 if score .ice_path tutorial matches 3 positioned -201 -26 3018 run tickingarea add ~ ~ ~ ~18 ~22 ~14 pathway_temp true
# execute if score .timer tutorial matches 0 run structure load spark:yoda_melt -36 -23 3014
# execute if score .timer tutorial matches 0 run structure load spark:yoda_melt_stairs -34 -26 3014
execute if score .timer tutorial matches 1 run event entity @e[type=spark:breadcrumb_1,x=0,y=-24,z=3021,r=250] spark:despawn
execute if score .timer tutorial matches 1 run event entity @e[type=spark:breadcrumb_2,x=0,y=-24,z=3021,r=250] spark:despawn
execute if score .timer tutorial matches 1 run event entity @e[type=spark:breadcrumb_3,x=0,y=-24,z=3021,r=250] spark:despawn
execute if score .timer tutorial matches 1 run event entity @e[type=spark:breadcrumb_4,x=0,y=-24,z=3021,r=250] spark:despawn
execute if score .timer tutorial matches 10 run tp @e[type=spark:kelleran_beq,x=0,y=-24,z=3021,r=250] 3.5 -25 3018.5 45 0
execute if score .timer tutorial matches 10 run tp @e[type=spark:padawan_1,x=0,y=-24,z=3021,r=250] 3.5 -25 3024.5 135 0
execute if score .timer tutorial matches 10 run tp @e[type=spark:padawan_2,x=0,y=-24,z=3021,r=250] 1.5 -25 3025.5 165 0
execute if score .timer tutorial matches 10 run tp @e[type=spark:padawan_3,x=0,y=-24,z=3021,r=250] -0.5 -25 3025.5 -165 0


# execute if score .timer tutorial matches 831 if score .ice_path tutorial matches 1 run structure load spark:ice_left -197 -31 3071
# execute if score .timer tutorial matches 831 if score .ice_path tutorial matches 2 run structure load spark:ice_center -231 -29 3046
# execute if score .timer tutorial matches 831 if score .ice_path tutorial matches 3 run structure load spark:ice_right -201 -26 3018

# fills
execute if score .timer tutorial matches 831 if score .ice_path tutorial matches 1 run fill -184 -27 3076 -177 -19 3086 air
execute if score .timer tutorial matches 831 if score .ice_path tutorial matches 2 run fill -222 -28 3051 -231 -20 3059 air
execute if score .timer tutorial matches 831 if score .ice_path tutorial matches 3 run fill -191 -24 3024 -195 -17 3020 air

execute if score .timer tutorial matches 831 run tickingarea remove pathway_temp
execute if score .timer tutorial matches 831.. run function spark/tutorial/next
