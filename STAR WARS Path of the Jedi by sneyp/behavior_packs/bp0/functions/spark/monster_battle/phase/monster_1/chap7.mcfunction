#
effect @a regeneration 0
execute if score .timer .monster_battle matches 2 run scoreboard players set @a SS_ui_tutorial 31

execute as @e[type=spark:sand_beast] at @s if entity @a[r=8,scores={item.type=1..,item.charge=40..}] run scoreboard players set .trigger_1 .monster_battle 1
execute if score .timer .monster_battle matches 1 if score .trigger_1 .monster_battle matches 0 run event entity @e[type=spark:sand_beast] spark:reset
execute if score .timer .monster_battle matches 2 if score .trigger_1 .monster_battle matches 0 run playsound sound.spark.sandbeast_defeated @a
execute if score .timer .monster_battle matches 2 if score .trigger_1 .monster_battle matches 0 run music stop 4.0
execute if score .timer .monster_battle matches 2 if score .trigger_1 .monster_battle matches 0 run event entity @e[type=spark:sand_beast] spark:dizzy
execute if score .timer .monster_battle matches 10.. if score .trigger_1 .monster_battle matches 0 run scoreboard players set .timer .monster_battle 10
execute if score .timer .monster_battle matches 12 run playsound sound.spark.sandbeast_soothed @a
execute if score .timer .monster_battle matches 13 run titleraw @s actionbar {"rawtext":[{ "text": "hud:clear" }]}
#execute if score .timer .monster_battle matches 12 run event entity @e[type=spark:sand_beast] spark:melee
execute if score .timer .monster_battle matches 13 run event entity @e[type=spark:sand_beast] spark:sleep
execute if score .timer .monster_battle matches 12 run titleraw @a actionbar {"rawtext":[{ "text": "hud:announce:" },{"translate":"arena.announcement.monster_soothed.announcement1", "with": [ "\n" ] }]}
execute if score .timer .monster_battle matches 100 run title @a actionbar hud:fade_out_1
execute if score .timer .monster_battle matches 80 run playsound sound.spark.transitioner_camp @a
execute if score .timer .monster_battle matches 105 run playsound sound.spark.success_major @a
execute if score .timer .monster_battle matches 110.. run function spark/monster_battle/phase/next
