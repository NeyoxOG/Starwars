scoreboard players add ".return_timer" dueling_story 1
execute if score ".return_timer" dueling_story matches 1 run scoreboard players reset @e[type=spark:duel_force_field] SS_const
execute if score ".return_timer" dueling_story matches 1 run title @a actionbar hud:fade_out_1
execute if score ".return_timer" dueling_story matches 21.. run scoreboard players set @s SS_ui_tutorial 0
execute if score ".return_timer" dueling_story matches 21 run title @a actionbar hud:fade_in_1
execute if score ".return_timer" dueling_story matches 21 unless score .global dueling_rank matches 0 run tp @a 9007.5 22 8975.5 90 0
execute if score ".return_timer" dueling_story matches 21 if score .global dueling_rank matches 0 run tp @a 9000.5 22.00 8996.5 180 0
execute if score ".return_timer" dueling_story matches 21 run  tag @e[type=spark:astromech,tag=!npc] remove no_tp

execute if score ".return_timer" dueling_story matches 21 run replaceitem entity @a slot.hotbar 1 spark:push 1 0 {"item_lock": { "mode": "lock_in_slot" }}
execute if score ".return_timer" dueling_story matches 21 run replaceitem entity @a slot.hotbar 2 spark:grab 1 0 {"item_lock": { "mode": "lock_in_slot" }}
execute if score ".return_timer" dueling_story matches 21 run replaceitem entity @a slot.hotbar 3 spark:pull 1 0 {"item_lock": { "mode": "lock_in_slot" }}
execute if score ".return_timer" dueling_story matches 21 run gamerule naturalregeneration true
execute if score ".return_timer" dueling_story matches 25 unless entity @a[tag=duel_win] run function spark/dueling/story/outro/on_group_loss
execute if score ".return_timer" dueling_story matches 25 if entity @a[tag=duel_win] run function spark/dueling/story/outro/on_group_win
execute if score ".return_timer" dueling_story matches 25 positioned 8989.5 22.00 8975.5 as @e[type=spark:duel_force_field,r=10] run function spark/dueling/place_display_duelist

execute if score ".return_timer" dueling_story matches 25 run inputpermission set @a camera enabled
execute if score ".return_timer" dueling_story matches 25 run inputpermission set @a movement enabled
execute if score ".return_timer" dueling_story matches 41 run tag @a remove waiting
execute if score ".return_timer" dueling_story matches 41 run scoreboard players set ".return_timer" dueling_story 0