#
execute if score .timer .monster_battle matches 10 run event entity @e[type=spark:clone_trooper] spark:despawn
execute if score .timer .monster_battle matches 10 run summon spark:clone_trooper 6333.37 162.00 5995.06 113.57 -0.25 spark:color_red
execute if score .timer .monster_battle matches 10 run summon spark:clone_trooper 6353.90 162.00 5995.16 151.03 -0.88 spark:color_red
execute if score .timer .monster_battle matches 10 run summon spark:clone_trooper 6367.81 157.00 5961.89 66.93 4.44 spark:color_red
execute if score .timer .monster_battle matches 10 run summon spark:clone_trooper 6317.06 158.00 5992.07 -127.48 1.62 spark:color_red
execute if score .timer .monster_battle matches 10 run event entity @e[type=spark:clone_trooper] spark:push_off

execute if score .timer .monster_battle matches 10 run event entity @e[type=spark:tusken_raider_melee] spark:despawn
execute if score .timer .monster_battle matches 10 run summon spark:tusken_raider_melee 6369.31 157.00 5967.42 30 0 spark:passive
execute if score .timer .monster_battle matches 10 run summon spark:tusken_raider_melee 6371.33 157.00 5970.84 109 0 spark:passive
execute if score .timer .monster_battle matches 10 run summon spark:tusken_raider_melee 6367.82 157.00 5982.23 153.51 0 spark:passive

execute if score .timer .monster_battle matches 2 run scoreboard players set .monster_1_complete .monster_battle 1
execute if score .timer .monster_battle matches 2 run scoreboard players set @a SS_ui_task 0
execute if score .timer .monster_battle matches 2 run tp @a 6360.99 157.00 5976.56 -19.09 -3.90
execute if score .timer .monster_battle matches 12 run structure load spark:cage_v3 6362 157 5987
execute if score .timer .monster_battle matches 42 run structure load spark:cage_v3 6362 157 5987
execute if score .timer .monster_battle matches 17 run title @a actionbar hud:fade_in_1
#execute if score .timer .monster_battle matches 12 run titleraw @a actionbar {"rawtext":[{ "text": "hud:announce:" },{"translate":"monster_arena.capture.announcement.monster1", "with": [ "\n" ] }]}
execute if score .timer .monster_battle matches 2 run scoreboard players set @a SS_ui_task 0
execute if score .timer .monster_battle matches 2 run scoreboard players set @a SS_ui_tutorial 0

execute if score .timer .monster_battle matches 10 run summon spark:sand_beast 6366.0 157.00 5991.79 -178.94 -11.52 spark:sleep
# execute if score .timer .monster_battle matches 10 run summon spark:holo_obi_wan 6360.41 157.00 5987.56 180 0

execute if score .timer .monster_battle matches 1.. positioned 6354.15 157.00 5978.50 run tp @e[type=spark:recon_trooper,c=1,tag=!loaded] 6366.32 157.00 5984.03 163.51 -9.12
execute if score .timer .monster_battle matches 1.. positioned 6354.15 157.00 5978.50 run dialogue change @e[type=spark:recon_trooper,r=20,tag=!loaded] spark:monster_arena.guard.3
execute if score .timer .monster_battle matches 1.. positioned 6354.15 157.00 5978.50 run tag @e[type=spark:recon_trooper,c=1] add loaded

#
execute as @e[type=spark:recon_trooper] at @s run particle spark:npc_exclamation ~ ~2.7 ~

#playanimation @e[type=spark:holo_obi_wan] animation.spark.quest_master_hologram.invisible

#
execute if score .npc .monster_battle matches 1 positioned 6354.15 157.00 5978.50 run dialogue change @e[type=spark:recon_trooper,r=20] spark:monster_arena.guard.4
execute if score .npc .monster_battle matches 1 run function spark/monster_battle/phase/next

#
execute if score .timer .monster_battle matches 10 run event entity @e[type=spark:recon_trooper] spark:set_skin_1