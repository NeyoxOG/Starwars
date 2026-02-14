#
execute if score .timer .monster_battle matches 1..470 run event entity @e[type=spark:sand_beast] spark:despawn
execute if score .timer .monster_battle matches 1..470 run event entity @e[type=spark:holo_obi_wan] spark:despawn

execute if score .timer .monster_battle matches 2 run function spark/cutscene/start_ch08_c01

execute if score .timer .monster_battle matches 472 run fill 6362 164 5987 6372 157 5995 air
execute if score .timer .monster_battle matches 472 run summon spark:recon_trooper 6329.54 157.00 5975.87 -168.58 -10.85 spark:quest_npc
execute if score .timer .monster_battle matches 473 run event entity @e[type=spark:recon_trooper] spark:set_skin_1
execute if score .timer .monster_battle matches 472 run gamemode spectator @a

execute if score .timer .monster_battle matches 480 run scoreboard players set .respawn .monster_battle 1
execute if score .timer .monster_battle matches 480 run function spark/monster_battle/phase/next
execute if score .timer .monster_battle matches 1..500 run scoreboard players set @a SS_ui_tutorial 0