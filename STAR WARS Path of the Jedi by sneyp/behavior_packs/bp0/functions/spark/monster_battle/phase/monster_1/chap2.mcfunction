#
execute if score .timer .monster_battle matches 1 run titleraw @a actionbar {"rawtext":[{ "text": "hud:location:" },{"translate":"arena.location_banner.tatooine.location1", "with": [ "\n" ] }]}
execute if score .timer .monster_battle matches 1 run playsound sound.spark.transitioner_front_of_ship_neutral @a
#
execute if score .timer .monster_battle matches 1 run event entity @e[type=spark:clone_trooper] spark:despawn
execute if score .timer .monster_battle matches 1 run summon spark:clone_trooper 6333.37 162.00 5995.06 113.57 -0.25 spark:color_red
execute if score .timer .monster_battle matches 1 run summon spark:clone_trooper 6353.90 162.00 5995.16 151.03 -0.88 spark:color_red
execute if score .timer .monster_battle matches 1 run summon spark:clone_trooper 6367.81 157.00 5961.89 66.93 4.44 spark:color_red
execute if score .timer .monster_battle matches 1 run summon spark:clone_trooper 6317.06 158.00 5992.07 -127.48 1.62 spark:color_red
execute if score .timer .monster_battle matches 2 run event entity @e[type=spark:clone_trooper] spark:push_off

execute if score .timer .monster_battle matches 1 run event entity @e[type=spark:sand_beast] spark:despawn
execute if score .timer .monster_battle matches 1 run event entity @e[type=spark:holo_obi_wan] spark:despawn
execute if score .timer .monster_battle matches 1 run fill 6362 164 5987 6372 157 5995 air
execute if score .timer .monster_battle matches 1 run event entity @e[type=spark:recon_trooper] spark:despawn
execute if score .timer .monster_battle matches 1 run event entity @e[type=spark:holo_obi_wan] spark:despawn
execute if score .timer .monster_battle matches 1 run event entity @e[type=spark:tusken_raider_melee] spark:despawn
execute if score .timer .monster_battle matches 1 run summon spark:tusken_raider_melee 6369.31 157.00 5967.42 30 0 spark:passive
execute if score .timer .monster_battle matches 1 run summon spark:tusken_raider_melee 6371.33 157.00 5970.84 109 0 spark:passive
execute if score .timer .monster_battle matches 1 run summon spark:recon_trooper 6329.54 157.00 5975.87 -168.58 -10.85 spark:quest_npc
execute if score .timer .monster_battle matches 1 run event entity @e[type=spark:recon_trooper] spark:set_skin_1
execute if score .timer .monster_battle matches 1 run summon spark:holo_obi_wan 6360.41 157.00 5987.56 180 0
execute if score .timer .monster_battle matches 3 positioned 6329.54 157.00 5975.87 run dialogue change @e[type=spark:recon_trooper,r=10] spark:monster_arena.guard.1

#
execute positioned 6296.68 158.00 5998.76 if entity @p[r=18] run scoreboard players set .npc .monster_battle 1

#
execute if score .npc .monster_battle matches 1 positioned 6329.54 157.00 5975.87 run dialogue change @e[type=spark:recon_trooper,r=10] spark:monster_arena.guard.2
execute if score .npc .monster_battle matches 1 run function spark/monster_battle/phase/next

#
execute as @e[type=spark:recon_trooper] at @s run particle spark:npc_exclamation ~ ~3.0 ~