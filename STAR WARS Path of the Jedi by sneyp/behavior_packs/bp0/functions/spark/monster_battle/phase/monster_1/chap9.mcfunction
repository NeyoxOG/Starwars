#
execute if score .timer .monster_battle matches 10 run event entity @e[type=spark:holo_obi_wan] spark:quest_npc
execute if score .timer .monster_battle matches 10 run event entity @e[type=spark:holo_obi_wan] spark:appear
execute if score .timer .monster_battle matches 11 positioned 6360.41 157.00 5987.56 run dialogue change @e[type=spark:holo_obi_wan,c=1] spark:monster_arena.obiwan.end

execute if score .timer .monster_battle matches 10 run scoreboard objectives add Tmp_mb_timer dummy
execute if score .timer .monster_battle matches 11 run scoreboard players set .tmp_timer Tmp_mb_timer 0
# after interaction with obi wan
execute if score .npc .monster_battle matches 1 run scoreboard players add .tmp_timer Tmp_mb_timer 1


execute if score .npc .monster_battle matches 1 if score .tmp_timer Tmp_mb_timer matches 1 run playanimation @e[type=spark:holo_obi_wan] animation.spark.quest_master_hologram.disappear
execute if score .npc .monster_battle matches 1 if score .tmp_timer Tmp_mb_timer matches 1 run scoreboard players set .respawn .monster_battle 0
execute if score .npc .monster_battle matches 1 if score .tmp_timer Tmp_mb_timer matches 20 run function spark/cutscene/start_ch02_c11



execute if score .npc .monster_battle matches 1 if score .tmp_timer Tmp_mb_timer matches 510 if score "Monster_Battle_Arena" SS_achievements matches 1 if score .monster_2_complete .monster_battle matches 1 run function spark/achievement/trigger/monster_battle_post
execute if score .npc .monster_battle matches 1 if score .tmp_timer Tmp_mb_timer matches 510 run scoreboard players set .monster_1_complete .monster_battle 1
execute if score .npc .monster_battle matches 1 if score .tmp_timer Tmp_mb_timer matches 510 run function spark/achievement/trigger/monster_battle
execute if score .npc .monster_battle matches 1 if score .tmp_timer Tmp_mb_timer matches 510 run function spark/monster_battle/phase/next

#
execute as @e[type=spark:holo_obi_wan] at @s run particle spark:npc_exclamation ~ ~3.0 ~
