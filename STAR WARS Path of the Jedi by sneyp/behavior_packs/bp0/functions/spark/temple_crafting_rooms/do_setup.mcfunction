# © Spark Universe, 2023
# authors: FetchBot
# description: 
# called by: spark/setup
kill @e[type=spark:lightsaber_crafting_table,x=8835,y=24,z=8949,r=32]
kill @e[type=spark:lightsaber_ui_npc,x=8835,y=24,z=8949,r=32]
summon spark:lightsaber_crafting_table 8847 24.00 8949 0 0
summon spark:lightsaber_crafting_table 8859 25 8951 -90 0
summon spark:lightsaber_crafting_table 8847 25 8963 0 0
summon spark:lightsaber_crafting_table 8835 25 8951 90 0

schedule delay add spark/temple_crafting_rooms/delayed_setup_1s 1S
schedule delay add spark/temple_crafting_rooms/delayed_setup_2s 2S