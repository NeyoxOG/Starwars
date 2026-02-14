#
execute if score .timer .monster_battle matches 1 run titleraw @a actionbar {"rawtext":[{ "text": "hud:location:" },{"translate":"arena.location_banner.felucia.location1", "with": [ "\n" ] }]}
execute if score .timer .monster_battle matches 1 run playsound sound.spark.transitioner_front_of_ship_neutral @a
#
execute if score .timer .monster_battle matches 1 run event entity @e[type=spark:clone_trooper] spark:despawn
execute if score .timer .monster_battle matches 1 run summon spark:clone_trooper 8933.41 52.00 5756.92 -119.53 8.31 spark:color_red
execute if score .timer .monster_battle matches 1 run summon spark:clone_trooper 8933.10 52.00 5737.15 -56.09 7.16 spark:color_red
execute if score .timer .monster_battle matches 1 run summon spark:clone_trooper 8932.38 52.00 5742.58 -86.35 0.90 spark:color_red
execute if score .timer .monster_battle matches 1 run summon spark:clone_trooper 8960.38 48.00 5744.60 30.39 12.38 spark:color_red
execute if score .timer .monster_battle matches 2 run event entity @e[type=spark:clone_trooper] spark:push_off

execute if score .timer .monster_battle matches 1 run event entity @e[type=spark:acklay] spark:despawn
execute if score .timer .monster_battle matches 1 run event entity @e[type=spark:holo_obi_wan] spark:despawn
execute if score .timer .monster_battle matches 1 run fill 8942 48 5755 8952 55 5763 air
execute if score .timer .monster_battle matches 1 run event entity @e[type=spark:sand_beast] spark:despawn
execute if score .timer .monster_battle matches 1 run fill 6362 164 5987 6372 157 5995 air
execute if score .timer .monster_battle matches 1 run event entity @e[type=spark:recon_trooper] spark:despawn
execute if score .timer .monster_battle matches 1 run summon spark:recon_trooper 8952.72 48.00 5743.73 20 -5.60 spark:quest_npc
execute if score .timer .monster_battle matches 1 run summon spark:holo_obi_wan 8953 48 5756 180 0
execute if score .timer .monster_battle matches 1 run event entity @e[type=spark:recon_trooper] spark:set_skin_1
execute if score .timer .monster_battle matches 3 positioned 8952.72 48.00 5743.73 run dialogue change @e[type=spark:recon_trooper,r=20] spark:monster_arena.guard.1b

#
execute positioned 9090.70 49.54 5769.51 if entity @p[r=90] run scoreboard players set .npc .monster_battle 1

#
execute if score .npc .monster_battle matches 1 positioned 8952.72 48.00 5743.73 run dialogue change @e[type=spark:recon_trooper,r=20] spark:monster_arena.guard.2b
execute if score .npc .monster_battle matches 1 run function spark/monster_battle/phase/next

#
execute as @e[type=spark:recon_trooper] at @s run particle spark:npc_exclamation ~ ~3.0 ~
execute if score .timer .monster_battle matches 1 run scoreboard players set @a SS_ui_tutorial 0