# © Spark Universe, 2023
# authors: Arcaniax
# description: runs 20/s 
# called by: tutorial/loop

# PLAYER UP TO CRYSTAL


# execute if score .timer tutorial matches 0 run scoreboard players set @a SS_ui_task 0
execute if score .timer tutorial matches 0 run scoreboard players set @a SS_ui_tutorial 3

execute if score .timer tutorial matches 2.. as @a run scoreboard players add @s t5 0
execute if score .timer tutorial matches 2.. as @a[scores={t5=1..92}] run scoreboard players add @s t5 1
execute if score .timer tutorial matches 2.. as @a[tag=use_pull,tag=!has_crystal,scores={t5=0}] run scoreboard players add @s t5 1

scoreboard players add @e[type=spark:kyber_crystal] t5 1
scoreboard players add @e[type=spark:kyber_crystal,scores={t5=1}] t5 1

execute if score .timer tutorial matches 2.. as @a[tag=use_pull,scores={t5=1..}] run tag @s[tag=!has_crystal] add no_force_end
execute if score .timer tutorial matches 2.. as @a[tag=use_pull,scores={t5=1}] run playsound sound.spark.crystal_grab @p
# execute if score .timer tutorial matches 2.. as @a[tag=!use_pull,scores={t5=1..}] run stopsound @p sound.spark.crystal_grab
execute if score .timer tutorial matches 2.. as @a[tag=!use_pull,scores={t5=1..}] run function spark/tutorial/chap2/drop_crystal
execute if score .timer tutorial matches 2.. as @p[scores={t5=1}] at @s at @e[type=spark:kyber_crystal_altar,c=1] run summon spark:kyber_crystal ~ ~2.75 ~ facing @s spark:retrieving

event entity @e[type=spark:kyber_crystal,scores={t5=88..}] spark:collect

execute if score .timer tutorial matches 2.. as @a[scores={t5=92..}] at @s run replaceitem entity @s slot.hotbar 0 spark:kyber 1 0 {"item_lock": { "mode": "lock_in_slot" }}
execute if score .timer tutorial matches 2.. as @a[scores={t5=92..}] at @s run tag @s add has_crystal
execute if score .timer tutorial matches 2.. as @a[scores={t5=92..}] at @s run playsound sound.spark.success_major @s
execute if score .timer tutorial matches 2.. as @a[scores={t5=92..}] at @s run tag @s remove no_force_end
execute if score .timer tutorial matches 2.. as @a[scores={t5=92..}] at @s run scoreboard players set @s SS_ui_task 0


execute if score .timer tutorial matches 2.. unless entity @a[tag=!has_crystal] run function spark/tutorial/next


# cave shaking
scoreboard players random .shake tutorial 0 7500
execute if score .shake tutorial matches 1..10 run camerashake add @a 0.2 2
execute if score .shake tutorial matches 0 run camerashake add @a 0.3 2
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