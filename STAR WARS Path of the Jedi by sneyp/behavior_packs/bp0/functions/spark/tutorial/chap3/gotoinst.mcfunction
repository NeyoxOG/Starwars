function spark/tutorial/chap3/goto
tp @a 3028.58 -56.00 3042.01

scoreboard players set .substate tutorial 6
function spark/lightsaber/give_lightsaber
replaceitem entity @s slot.hotbar 3 spark:pull 1 0 {"item_lock": { "mode": "lock_in_slot" }}
replaceitem entity @s slot.hotbar 2 spark:grab 1 0 {"item_lock": { "mode": "lock_in_slot" }}
replaceitem entity @s slot.hotbar 1 spark:push 1 0 {"item_lock": { "mode": "lock_in_slot" }}
tag @a remove instance_finished
tag @a remove assigned