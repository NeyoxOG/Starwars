#
function spark/monster_battle/setup

# tp @a 6350.97 175.75 5974.40 -70 40

#replaceitem entity @a slot.hotbar 2 spark:pull 1 0 {"item_lock": { "mode": "lock_in_slot" }}
#replaceitem entity @a slot.hotbar 3 spark:grab 1 0 {"item_lock": { "mode": "lock_in_slot" }}
#replaceitem entity @a slot.hotbar 4 spark:push 1 0 {"item_lock": { "mode": "lock_in_slot" }}

music stop 7.0
scoreboard players add .id .monster_battle 1
scoreboard players set .monster .monster_battle 1
scoreboard players set .phase .monster_battle 0
function spark/monster_battle/phase/next

scoreboard players set .monster_stun .monster_battle 0

scoreboard players set @a SS_ui_tutorial 0
scoreboard players set @a SS_ui_task 0

#
time set sunset