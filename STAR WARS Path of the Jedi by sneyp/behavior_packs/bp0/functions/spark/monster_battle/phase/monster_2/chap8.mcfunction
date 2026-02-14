#
execute if score .timer .monster_battle matches 10 run event entity @e[type=spark:clone_trooper] spark:despawn
execute if score .timer .monster_battle matches 10 run summon spark:clone_trooper 8933.41 52.00 5756.92 -119.53 8.31 spark:color_red
execute if score .timer .monster_battle matches 10 run summon spark:clone_trooper 8933.10 52.00 5737.15 -56.09 7.16 spark:color_red
execute if score .timer .monster_battle matches 10 run summon spark:clone_trooper 8932.38 52.00 5742.58 -86.35 0.90 spark:color_red
execute if score .timer .monster_battle matches 10 run summon spark:clone_trooper 8960.38 48.00 5744.60 30.39 12.38 spark:color_red
execute if score .timer .monster_battle matches 10 run event entity @e[type=spark:clone_trooper] spark:push_off

execute if score .timer .monster_battle matches 2 run scoreboard players set .monster_2_complete .monster_battle 1
execute if score .timer .monster_battle matches 2 run scoreboard players set @a SS_ui_task 0
execute if score .timer .monster_battle matches 2 run tp @a 8949.35 48.00 5744.26 13.51 -7.37
execute if score .timer .monster_battle matches 12 run structure load spark:cage_vfinal 8942 48 5755
execute if score .timer .monster_battle matches 42 run structure load spark:cage_vfinal 8942 48 5755
execute if score .timer .monster_battle matches 17 run title @a actionbar hud:fade_in_1
#execute if score .timer .monster_battle matches 12 run titleraw @a actionbar {"rawtext":[{ "text": "hud:announce:" },{"translate":"monster_arena.capture.announcement.monster2", "with": [ "\n" ] }]}
execute if score .timer .monster_battle matches 2 run scoreboard players set @a SS_ui_task 0
execute if score .timer .monster_battle matches 2 run scoreboard players set @a SS_ui_tutorial 0

execute if score .timer .monster_battle matches 10 run summon spark:acklay 8946.0 48.00 5759.50 180 -9.25 spark:sleep
# execute if score .timer .monster_battle matches 10 run summon spark:holo_obi_wan 8953 48 5756 180 0

execute if score .timer .monster_battle matches 1.. positioned 8946.82 48.00 5753.36 run tp @e[type=spark:recon_trooper,c=1,tag=!loaded] 8946.82 48.00 5753.36 -175.14 -3.61
execute if score .timer .monster_battle matches 1.. positioned 8946.82 48.00 5753.36 run dialogue change @e[type=spark:recon_trooper,r=20,tag=!loaded] spark:monster_arena.guard.3b
execute if score .timer .monster_battle matches 1.. positioned 8946.82 48.00 5753.36 run tag @e[type=spark:recon_trooper,c=1] add loaded

#
execute as @e[type=spark:recon_trooper] at @s run particle spark:npc_exclamation ~ ~2.7 ~

#
execute if score .npc .monster_battle matches 1 positioned 8946.82 48.00 5753.36 run dialogue change @e[type=spark:recon_trooper,r=20] spark:monster_arena.guard.4b
execute if score .npc .monster_battle matches 1 run function spark/monster_battle/phase/next

#
execute if score .timer .monster_battle matches 10 run event entity @e[type=spark:recon_trooper] spark:set_skin_1