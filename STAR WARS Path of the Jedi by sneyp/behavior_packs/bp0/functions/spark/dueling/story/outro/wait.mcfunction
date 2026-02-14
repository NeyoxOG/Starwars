# scoreboard players add @s dueling_story 1
inputpermission set @a[tag=waiting] camera enabled
inputpermission set @a[tag=waiting] movement enabled
# execute if score @s dueling_story matches 1 run title @a[r=50] actionbar hud:fade_in_1

# execute if score @s dueling_story matches 1 run function spark/lightsaber/give_lightsaber
# execute if score @s dueling_story matches 1 run replaceitem entity @a slot.hotbar 4 spark:pull 1 0 {"item_lock": { "mode": "lock_in_slot" }}
# execute if score @s dueling_story matches 1 run replaceitem entity @a slot.hotbar 3 spark:grab 1 0 {"item_lock": { "mode": "lock_in_slot" }}
# execute if score @s dueling_story matches 1 run replaceitem entity @a slot.hotbar 2 spark:push 1 0 {"item_lock": { "mode": "lock_in_slot" }}
execute if entity @a[tag=!waiting] run scoreboard players set @a[tag=waiting] SS_ui_tutorial 13

#if anyone is dueling
execute unless entity @a[tag=!waiting] run function spark/dueling/story/outro/return
#if there are still people dueling
# execute unless entity @a[tag=!waiting] run function spark/dueling/story/outro/start