#
execute as @e[type=spark:yoda] at @s run particle spark:npc_exclamation ~ ~1.75 ~

execute if score .timer tutorial matches 0 run scoreboard players add .backfill tutorial 0

# this appears to be super laggy, even on pc!
execute positioned -191.5 -28.00 3053.5 if entity @a[r=60] if score .backfill tutorial matches 0 if score .ice_path tutorial matches 1 run structure load spark:ice_left -197 -31 3071
execute positioned -191.5 -28.00 3053.5 if entity @a[r=60] if score .backfill tutorial matches 0 if score .ice_path tutorial matches 2 run structure load spark:ice_center -231 -29 3046
execute positioned -191.5 -28.00 3053.5 if entity @a[r=60] if score .backfill tutorial matches 0 if score .ice_path tutorial matches 3 run structure load spark:ice_right -201 -26 3018
execute positioned -191.5 -28.00 3053.5 if entity @a[r=60] if score .backfill tutorial matches 0 run scoreboard players set .backfill tutorial 1

# sound @william.savage ?
execute if score .timer tutorial matches 75.. run scoreboard players set @a SS_ui_tutorial 1005
execute if score .timer tutorial matches 75.. run scoreboard players set @a SS_ui_task 0


execute if score .timer tutorial matches 80.. positioned 0.83 -24.98 3021.34 if entity @p[r=30] run function spark/tutorial/next

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