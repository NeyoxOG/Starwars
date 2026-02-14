#
# execute as @e[type=spark:kelleran_beq] at @s run particle spark:npc_exclamation ~ ~2.5 ~
execute if score .timer tutorial matches 0 positioned 0.5 -25.00 3021.5 run dialogue change @e[c=1,r=1,type=spark:yoda] spark:illum.yoda_5

# re enable the dialog for kelleran to show the player the final dialog
execute if score .timer tutorial matches 0 positioned 0.5 -25.00 3021.5 run event entity @e[c=1,type=spark:kelleran_beq] spark:quest_npc
execute if score .timer tutorial matches 1 positioned 0.5 -25.00 3021.5 run dialogue change @e[c=1,type=spark:kelleran_beq] spark:illum.kelleran_4
execute if score .timer tutorial matches 1 positioned 0.5 -25.00 3021.5 run event entity @e[c=1,type=spark:kelleran_beq] spark:enable_quest_icon

execute if score .timer tutorial matches 1 run dialogue open @e[c=1,type=spark:kelleran_beq] @a spark:illum.kelleran_4

execute if score .timer tutorial matches 0 run scoreboard players set @a SS_ui_tutorial 0

execute if score .timer tutorial matches 2.. if score .npc_trigger tutorial matches 1.. run event entity @e[c=1,type=spark:kelleran_beq] spark:disable_quest_icon
execute if score .timer tutorial matches 2.. if score .npc_trigger tutorial matches 1.. run function spark/tutorial/next_chapter

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