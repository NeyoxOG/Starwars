#check if new player already has lightsaber
tag @s add tmp
tag @s[hasitem={item=spark:lightsaber_01_single}] remove tmp
tag @s[hasitem={item=spark:lightsaber_02_single}] remove tmp
tag @s[hasitem={item=spark:lightsaber_03_single}] remove tmp
tag @s[hasitem={item=spark:lightsaber_04_single}] remove tmp
tag @s[hasitem={item=spark:lightsaber_05_single}] remove tmp
tag @s[hasitem={item=spark:lightsaber_06_single}] remove tmp
tag @s[hasitem={item=spark:lightsaber_07_single}] remove tmp
tag @s[hasitem={item=spark:lightsaber_08_single}] remove tmp
tag @s[hasitem={item=spark:lightsaber_09_single}] remove tmp
tag @s[hasitem={item=spark:lightsaber_10_single}] remove tmp
tag @s[hasitem={item=spark:lightsaber_11_single}] remove tmp
tag @s[hasitem={item=spark:lightsaber_12_single}] remove tmp
tag @s[hasitem={item=spark:lightsaber_13_single}] remove tmp
tag @s[hasitem={item=spark:lightsaber_14_single}] remove tmp
tag @s[hasitem={item=spark:lightsaber_15_single}] remove tmp
tag @s[hasitem={item=spark:lightsaber_01_double}] remove tmp
tag @s[hasitem={item=spark:lightsaber_02_double}] remove tmp
tag @s[hasitem={item=spark:lightsaber_03_double}] remove tmp
tag @s[hasitem={item=spark:lightsaber_04_double}] remove tmp
tag @s[hasitem={item=spark:lightsaber_05_double}] remove tmp
tag @s[hasitem={item=spark:lightsaber_06_double}] remove tmp
tag @s[hasitem={item=spark:lightsaber_07_double}] remove tmp
tag @s[hasitem={item=spark:lightsaber_08_double}] remove tmp
tag @s[hasitem={item=spark:lightsaber_09_double}] remove tmp
tag @s[hasitem={item=spark:lightsaber_10_double}] remove tmp
tag @s[hasitem={item=spark:lightsaber_11_double}] remove tmp
tag @s[hasitem={item=spark:lightsaber_12_double}] remove tmp
tag @s[hasitem={item=spark:lightsaber_13_double}] remove tmp
tag @s[hasitem={item=spark:lightsaber_14_double}] remove tmp
tag @s[hasitem={item=spark:lightsaber_15_double}] remove tmp

#if not, give lightsaber
execute if entity @s[tag=tmp] run function spark/catchup/give_lightsaber

#check if new player is wearing robe
tag @s add tmp
tag @s[hasitem={item=spark:cloak_battleship}] remove tmp
tag @s[hasitem={item=spark:cloak_default}] remove tmp
tag @s[hasitem={item=spark:cloak_dueling}] remove tmp
tag @s[hasitem={item=spark:cloak_kamino}] remove tmp
tag @s[hasitem={item=spark:cloak_monster}] remove tmp
tag @s[hasitem={item=spark:cloak_puzzles}] remove tmp
#if not, give robe
execute if entity @s[tag=tmp] run replaceitem entity @s slot.armor.chest 0 spark:cloak_default 1 0 {"minecraft:keep_on_death":{},"minecraft:item_lock":{"mode":"lock_in_slot"}}

#give kyber crystal
execute if entity @p[tag=data_origin,hasitem={item=spark:kyber}] run replaceitem entity @s slot.hotbar 0 spark:kyber 1 0 {"minecraft:keep_on_death":{},"minecraft:item_lock":{"mode":"lock_in_slot"}}
#give force powers if host has them
execute if entity @p[tag=data_origin,hasitem={item=spark:push}] run replaceitem entity @s slot.hotbar 1 spark:push 1 0 {"minecraft:keep_on_death":{},"minecraft:item_lock":{"mode":"lock_in_slot"}}
execute if entity @p[tag=data_origin,hasitem={item=spark:grab}] run replaceitem entity @s slot.hotbar 2 spark:grab 1 0 {"minecraft:keep_on_death":{},"minecraft:item_lock":{"mode":"lock_in_slot"}}
execute if entity @p[tag=data_origin,hasitem={item=spark:pull}] run replaceitem entity @s slot.hotbar 3 spark:pull 1 0 {"minecraft:keep_on_death":{},"minecraft:item_lock":{"mode":"lock_in_slot"}}

#give astromech items if host has them
execute if entity @p[tag=data_origin,hasitem={item=spark:power_cell}] run replaceitem entity @s slot.hotbar 0 spark:power_cell 1 0 {"minecraft:keep_on_death":{},"minecraft:item_lock":{"mode":"lock_in_slot"}}
execute if entity @p[tag=data_origin,hasitem={item=spark:paint_tool}] run replaceitem entity @s slot.hotbar 1 spark:paint_tool 1 0 {"minecraft:keep_on_death":{},"minecraft:item_lock":{"mode":"lock_in_slot"}}
execute if entity @p[tag=data_origin,hasitem={item=spark:head_tool}] run replaceitem entity @s slot.hotbar 2 spark:head_tool 1 0 {"minecraft:keep_on_death":{},"minecraft:item_lock":{"mode":"lock_in_slot"}}
execute if entity @p[tag=data_origin,hasitem={item=spark:pattern_tool}] run replaceitem entity @s slot.hotbar 3 spark:pattern_tool 1 0 {"minecraft:keep_on_death":{},"minecraft:item_lock":{"mode":"lock_in_slot"}}

tag @s remove tmp