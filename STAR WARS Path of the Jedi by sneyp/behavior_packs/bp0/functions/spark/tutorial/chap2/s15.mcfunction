# © Spark Universe, 2023
# authors: Arcaniax
# description: runs 20/s 
# called by: tutorial/loop

# CAVE ESCAPE

execute if score .timer tutorial matches 0..10 run scoreboard players set @a SS_ui_task 0
execute if score .timer tutorial matches 0 run scoreboard players set @a SS_ui_tutorial 0

execute if score .timer tutorial matches 0 as @e[type=spark:kyber_crystal_altar] run event entity @s spark:disable_crystal

execute if score .timer tutorial matches 1 if score .ice_path tutorial matches 1 run structure load spark:ice_1_exit -362 -48 3130
execute if score .timer tutorial matches 1 if score .ice_path tutorial matches 2 run structure load spark:ice_2_exit -392 -29 3070
execute if score .timer tutorial matches 1 if score .ice_path tutorial matches 3 run structure load spark:ice_3_exit -397 -14 2934

execute if score .timer tutorial matches 0 run playsound sound.spark.ilum_cave_quake @a
execute if score .timer tutorial matches 0 run camerashake add @a 1 1
execute if score .timer tutorial matches 20 run camerashake add @a 0.75 1
execute if score .timer tutorial matches 40 run camerashake add @a 0.5 1
execute if score .timer tutorial matches 60 run camerashake add @a 0.25 2

execute if score .timer tutorial matches 0 run titleraw @a actionbar {"rawtext":[{ "text": "hud:announce:" },{"translate":"intro.ilum_caves.announcement.kyber_crystal.announcement1", "with": [ "\n" ] }]}

#temp skip
execute if score .timer tutorial matches 80.. run function spark/tutorial/next

# cave shaking
scoreboard players random .shake tutorial 0 5000
execute if score .shake tutorial matches 1..10 run camerashake add @a 0.25 2
execute if score .shake tutorial matches 0 run camerashake add @a 0.5 2
execute if score .shake tutorial matches 0..10 run playsound sound.spark.ilum_cave_quake_short @a

# death handling

scoreboard objectives add death dummy
scoreboard players add @a[scores={death=0..}] death 1

execute positioned -430.5 -50.00 3050.5 as @a[r=50] at @s if block ~ ~0.5 ~ minecraft:water run scoreboard players add @s death 0

execute as @a at @s if block ~ ~-0.1 ~ minecraft:barrier run scoreboard players add @s death 0
execute as @a at @s if block ~ ~-4.0 ~ minecraft:barrier run scoreboard players add @s death 0
execute as @a at @s if block ~ ~-4.5 ~ minecraft:barrier run scoreboard players add @s death 0
execute as @a at @s if score @s death matches 1 run title @s actionbar hud:fade_out_0
execute as @a at @s if score @s death matches 1 run playsound sound.spark.player_death_respawn @s
execute as @a at @s if score @s death matches 30 run scriptevent spark:ilum_death
execute as @a at @s if score @s death matches 40 run title @s actionbar hud:fade_in_1
execute as @a at @s if score @s death matches 40.. run scoreboard players reset @s death

# looping shaking
# execute if score .timer tutorial matches 200 run scoreboard players set .timer tutorial 0

# execute if score .timer tutorial matches 0.. positioned -371.5 -49.5 3142.5 if entity @a[r=10] run function spark/tutorial/next