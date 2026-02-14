# © Spark Universe, 2023
# authors: Arcaniax
# description: runs 20/s 
# called by: tutorial/loop

# ILLUM PATHING INSIDE & WALK UP TO YODA

#
execute if score .timer tutorial matches 0 run scoreboard players set @a SS_ui_tutorial 2
execute if score .timer tutorial matches 0 positioned 94.5 -26.00 3026.5 run event entity @e[c=1,type=spark:kelleran_beq] spark:reset_npc

execute if score .timer tutorial matches 3 run event entity @e[family=breadcrumb] spark:despawn

execute if score .timer tutorial matches 20 positioned 94.5 -26.00 3026.5 run tag @e[type=spark:kelleran_beq,c=1] add ilum_walk
execute if score .timer tutorial matches 20 positioned 94.5 -26.00 3026.5 run tag @e[type=spark:padawan_1,c=1] add ilum_walk_2
execute if score .timer tutorial matches 20 positioned 94.5 -26.00 3026.5 run tag @e[type=spark:padawan_2,c=1] add ilum_walk_2
execute if score .timer tutorial matches 20 positioned 94.5 -26.00 3026.5 run tag @e[type=spark:padawan_3,c=1] add ilum_walk_2

execute if score .timer tutorial matches 20 positioned 94.5 -26.00 3026.5 run event entity @e[tag=ilum_walk] spark:move1
execute if score .timer tutorial matches 20 positioned 94.5 -26.00 3026.5 run event entity @e[type=spark:padawan_1,c=1,tag=ilum_walk_2] spark:move1
execute if score .timer tutorial matches 20 positioned 94.5 -26.00 3026.5 run event entity @e[type=spark:padawan_2,c=1,tag=ilum_walk_2] spark:move9
execute if score .timer tutorial matches 20 positioned 94.5 -26.00 3026.5 run event entity @e[type=spark:padawan_3,c=1,tag=ilum_walk_2] spark:move5
execute if score .timer tutorial matches 11 run summon spark:breadcrumb_1 84.5 -26.00 3021.5
execute if score .timer tutorial matches 12 run summon spark:breadcrumb_2 59.32 -26.00 3021.5
execute if score .timer tutorial matches 13 run summon spark:breadcrumb_3 33.91 -26.00 3021.5
execute if score .timer tutorial matches 14 run summon spark:breadcrumb_4 8.0 -26.00 3021.5

execute if score .timer tutorial matches 11 run summon spark:breadcrumb_5 84.5 -26.00 3022.5
execute if score .timer tutorial matches 12 run summon spark:breadcrumb_6 59.32 -26.00 3023.5
execute if score .timer tutorial matches 13 run summon spark:breadcrumb_7 33.91 -26.00 3022.5
execute if score .timer tutorial matches 14 run summon spark:breadcrumb_8 6.5 -26.00 3022.5

execute if score .timer tutorial matches 11 run summon spark:breadcrumb_9 84.5 -26.00 3020.5
execute if score .timer tutorial matches 12 run summon spark:breadcrumb_10 59.32 -26.00 3019.5
execute if score .timer tutorial matches 13 run summon spark:breadcrumb_11 33.91 -26.00 3020.5
execute if score .timer tutorial matches 14 run summon spark:breadcrumb_12 6.5 -26.00 3020.5


execute if score .timer tutorial matches 20.. run tag @e[type=spark:kelleran_beq] remove go
execute if score .timer tutorial matches 20.. positioned 55.16 -26.00 3021.24 as @a[r=19] positioned 94.5 -26.00 3026.5 run tag @e[type=spark:kelleran_beq,c=1,r=15] add go
execute if score .timer tutorial matches 20.. positioned 55.16 -26.00 3021.24 as @a[r=19] positioned 94.5 -26.00 3026.5 run effect @e[type=spark:kelleran_beq,c=1,r=15] slowness 0

execute if score .timer tutorial matches 20.. positioned 94.5 -26.00 3026.5 as @e[tag=ilum_walk,tag=!go] at @s if entity @p[r=10] run effect @s speed 1 0 true
#execute if score .timer tutorial matches 20.. positioned 94.5 -26.00 3026.5 as @e[tag=ilum_walk,tag=!go] at @s if entity @p[r=5] run effect @s speed 1 1 true
execute if score .timer tutorial matches 20.. positioned 94.5 -26.00 3026.5 as @e[tag=ilum_walk,tag=!go] at @s unless entity @p[r=15] run effect @s slowness 10 10 true
execute if score .timer tutorial matches 20.. positioned 94.5 -26.00 3026.5 as @e[tag=ilum_walk,tag=!go] at @s unless entity @p[r=15] run tp @s ~ ~ ~ facing @p
execute if score .timer tutorial matches 20.. positioned 94.5 -26.00 3026.5 as @e[tag=ilum_walk,tag=!go] at @s if entity @e[type=spark:breadcrumb_4,r=6] run effect @s slowness 10 10 true
execute if score .timer tutorial matches 20.. positioned 94.5 -26.00 3026.5 as @e[tag=ilum_walk,tag=!go] at @s if entity @e[type=spark:breadcrumb_4,r=6] run tp @s ~ ~ ~ facing @p
execute if score .timer tutorial matches 20.. positioned 94.5 -26.00 3026.5 as @e[tag=ilum_walk,tag=!go] at @s unless entity @e[type=spark:breadcrumb_4,r=6] if entity @p[r=15] run effect @s slowness 0

execute if score .timer tutorial matches 20.. run tag @e[tag=ilum_walk_2] remove go
execute if score .timer tutorial matches 20.. as @e[type=spark:kelleran_beq] at @s run tag @e[tag=ilum_walk_2,c=1,r=7,rm=3] add go
#execute if score .timer tutorial matches 20.. positioned 94.5 -26.00 3026.5 as @e[tag=ilum_walk_2] at @s unless entity @e[type=spark:kelleran_beq,c=1,r=10] run effect @s speed 1 1 true
execute if score .timer tutorial matches 20.. positioned 94.5 -26.00 3026.5 as @e[tag=ilum_walk_2] at @s unless entity @e[type=spark:kelleran_beq,c=1,r=5] run effect @s speed 1 0 true
execute if score .timer tutorial matches 20.. positioned 94.5 -26.00 3026.5 as @e[tag=ilum_walk_2] at @s if entity @e[type=spark:kelleran_beq,c=1,r=3] run effect @s slowness 10 10 true
execute if score .timer tutorial matches 20.. positioned 94.5 -26.00 3026.5 as @e[tag=ilum_walk_2] at @s if entity @e[type=spark:kelleran_beq,c=1,r=3] run tp @s ~ ~ ~ facing @p
execute if score .timer tutorial matches 20.. positioned 94.5 -26.00 3026.5 as @e[tag=ilum_walk_2,tag=!go] at @s if entity @e[type=spark:kelleran_beq,c=1,r=3] if entity @e[tag=ilum_walk_2,r=2,rm=1] run effect @s slowness 10 10 true
execute if score .timer tutorial matches 20.. positioned 94.5 -26.00 3026.5 as @e[tag=ilum_walk_2,tag=!go] at @s if entity @e[type=spark:kelleran_beq,c=1,r=3] if entity @e[tag=ilum_walk_2,r=2,rm=1] run tp @s ~ ~ ~ facing @p
execute if score .timer tutorial matches 20.. positioned 94.5 -26.00 3026.5 as @e[tag=ilum_walk_2,tag=!go] at @s unless entity @e[tag=ilum_walk_2,r=2,rm=1] unless entity @e[type=spark:kelleran_beq,c=1,r=3] run effect @s slowness 0
execute if score .timer tutorial matches 20.. positioned 94.5 -26.00 3026.5 as @e[tag=ilum_walk_2,tag=go] at @s unless entity @e[type=spark:kelleran_beq,c=1,r=3] run effect @s slowness 0

execute if score .timer tutorial matches 100.. positioned 0.5 -25.0 3021.5 if entity @a[r=30] run function spark/tutorial/next
