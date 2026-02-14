#
execute if score .timer .monster_battle matches 1..490 run event entity @e[type=spark:acklay] spark:despawn
execute if score .timer .monster_battle matches 1..490 run event entity @e[type=spark:holo_obi_wan] spark:despawn


execute if score .timer .monster_battle matches 2 run function spark/cutscene/start_ch08_c11


execute if score .timer .monster_battle matches 493 run fill 8942 48 5755 8952 55 5763 air
execute if score .timer .monster_battle matches 493 run summon spark:recon_trooper 8953 47 5748 90 0 spark:quest_npc
execute if score .timer .monster_battle matches 494 run event entity @e[type=spark:recon_trooper] spark:set_skin_1
execute if score .timer .monster_battle matches 500 run scoreboard players set .respawn .monster_battle 1
execute if score .timer .monster_battle matches 500 run function spark/monster_battle/phase/next
execute if score .timer .monster_battle matches 1..500 run scoreboard players set @a SS_ui_tutorial 0