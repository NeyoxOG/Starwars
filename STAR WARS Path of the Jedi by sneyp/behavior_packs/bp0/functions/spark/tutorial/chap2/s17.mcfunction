#
execute as @e[type=spark:yoda] at @s run particle spark:npc_exclamation ~ ~1.75 ~
#
execute if score .timer tutorial matches 0 run scoreboard players set @a SS_ui_tutorial 0
#execute if score .timer tutorial matches 0 run tp @a -33.5 -22.00 3021.5 -90 0
execute if score .timer tutorial matches 0 run titleraw @a actionbar {"rawtext":[{ "text": "hud:location:" },{"translate":"spark.ui.location.jedi_temple", "with": [ "\n" ] }]}
execute if score .timer tutorial matches 0 positioned 0.5 -25.00 3021.5 run dialogue change @e[c=1,r=1,type=spark:yoda] spark:illum.yoda_4
execute if score .timer tutorial matches 0 as @e[type=spark:yoda] at @s run tp ~~~ 90 0

execute if score .timer tutorial matches 0 run scoreboard players set @a SS_ui_task 0

# execute if score .npc_trigger tutorial matches 1.. positioned 0.5 -25.00 3021.5 if entity @a[rm=30,m=2] as @a[r=30] run scoreboard players set @s SS_ui_tutorial 5

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

#
execute if score .timer tutorial matches 2.. if score .npc_trigger tutorial matches 1.. positioned 0.5 -25.00 3021.5 unless entity @a[rm=30,m=2] run function spark/tutorial/next