#

execute if score .timer .monster_battle matches 2 run scoreboard players set @a SS_ui_task 30
execute if score .timer .monster_battle matches 2 run function spark/monster_battle/phase/next
