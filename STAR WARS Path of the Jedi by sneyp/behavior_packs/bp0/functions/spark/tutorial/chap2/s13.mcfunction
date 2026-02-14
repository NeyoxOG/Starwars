# © Spark Universe, 2023
# authors: Arcaniax
# description: runs 20/s 
# called by: tutorial/loop

# PLAYER UP TO CRYSTAL

#execute if score .timer tutorial matches 0 run inputpermission set @a movement enabled

execute as @e[type=spark:marker,tag=calling_star] at @s run function spark/tutorial/chap2/star_call

execute if score .timer tutorial matches 0.. positioned -405 -29 3080 if entity @a[r=10] run function spark/tutorial/next
execute if score .timer tutorial matches 0.. positioned -371.5 -49.5 3142.5 if entity @a[r=10] run function spark/tutorial/next
execute if score .timer tutorial matches 0.. positioned -397.5 -14 2959 if entity @a[r=9] run function spark/tutorial/next


# cave shaking
scoreboard players random .shake tutorial 0 10000
execute if score .shake tutorial matches 1..10 run camerashake add @a 0.15 2
execute if score .shake tutorial matches 0 run camerashake add @a 0.36 2
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